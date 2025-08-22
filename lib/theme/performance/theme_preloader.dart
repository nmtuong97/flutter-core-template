import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../base/app_theme.dart';
import 'lazy_theme_loader.dart';
import 'theme_cache_manager.dart';

/// Intelligent theme preloader with usage pattern analysis
/// Predicts and preloads themes based on user behavior and app context
class ThemePreloader {
  factory ThemePreloader() => _instance;
  ThemePreloader._internal();
  static final ThemePreloader _instance = ThemePreloader._internal();

  final ThemeCacheManager _cacheManager = ThemeCacheManager();
  final LazyThemeLoader _lazyLoader = LazyThemeLoader();

  // Usage tracking
  final Map<String, ThemeUsageStats> _usageStats = {};
  final Map<String, DateTime> _lastUsed = {};
  final List<String> _recentThemes = [];

  // Preloading configuration
  static const int _maxRecentThemes = 5;
  static const Duration _usageTrackingWindow = Duration(days: 7);
  static const Duration _preloadInterval = Duration(minutes: 5);
  static const double _preloadThreshold = 0.3; // 30% usage probability

  Timer? _preloadTimer;
  bool _isEnabled = true;

  /// Initialize preloader with theme factories
  void initialize(Map<String, Future<AppTheme> Function()> themeFactories) {
    _startPreloadTimer(themeFactories);
  }

  /// Track theme usage for predictive loading
  void trackThemeUsage(
    String themeId, {
    ThemeUsageContext? context,
    DateTime? timestamp,
  }) {
    if (!_isEnabled) return;

    final now = timestamp ?? DateTime.now();

    // Update usage statistics
    _usageStats
        .putIfAbsent(
          themeId,
          () => ThemeUsageStats(themeId: themeId),
        )
        .recordUsage(context: context, timestamp: now);

    // Update recent themes list
    _lastUsed[themeId] = now;
    _recentThemes
      ..remove(themeId)
      ..insert(0, themeId);
    if (_recentThemes.length > _maxRecentThemes) {
      _recentThemes.removeRange(_maxRecentThemes, _recentThemes.length);
    }

    // Clean old usage data
    _cleanOldUsageData();
  }

  /// Predict themes likely to be used next
  List<ThemePrediction> predictNextThemes({
    ThemeUsageContext? currentContext,
    int maxPredictions = 3,
  }) {
    final predictions = <ThemePrediction>[];
    final now = DateTime.now();

    for (final entry in _usageStats.entries) {
      final themeId = entry.key;
      final stats = entry.value;

      final probability = _calculateUsageProbability(
        stats,
        currentContext: currentContext,
        currentTime: now,
      );

      if (probability > _preloadThreshold) {
        predictions.add(
          ThemePrediction(
            themeId: themeId,
            probability: probability,
            context: currentContext,
            reasoning: _generatePredictionReasoning(stats, currentContext, now),
          ),
        );
      }
    }

    // Sort by probability and return top predictions
    predictions.sort((a, b) => b.probability.compareTo(a.probability));
    return predictions.take(maxPredictions).toList();
  }

  /// Preload themes based on predictions
  Future<void> preloadPredictedThemes(
    Map<String, Future<AppTheme> Function()> themeFactories, {
    ThemeUsageContext? currentContext,
  }) async {
    if (!_isEnabled) return;

    final predictions = predictNextThemes(currentContext: currentContext);

    for (final prediction in predictions) {
      final factory = themeFactories[prediction.themeId];
      if (factory != null && !_cacheManager.isThemeCached(prediction.themeId)) {
        // Preload with background priority
        unawaited(
          _lazyLoader
              .getTheme(
            prediction.themeId,
            factory,
            priority: ThemeLoadPriority.background,
          )
              .catchError((dynamic error) {
            debugPrint('Failed to preload theme ${prediction.themeId}: $error');
            return Future<AppTheme>.error(error as Object); // Return error
          }),
        );
      }
    }
  }

  /// Calculate usage probability for a theme
  double _calculateUsageProbability(
    ThemeUsageStats stats, {
    required DateTime currentTime,
    ThemeUsageContext? currentContext,
  }) {
    var probability = 0.0;

    // Base frequency score (0.0 - 0.4)
    final frequencyScore = math.min(stats.totalUsages / 100.0, 0.4);
    probability += frequencyScore;

    // Recency score (0.0 - 0.3)
    final lastUsed = _lastUsed[stats.themeId];
    if (lastUsed != null) {
      final daysSinceLastUse = currentTime.difference(lastUsed).inDays;
      final recencyScore = math.max(0, 0.3 - (daysSinceLastUse * 0.05));
      probability += recencyScore;
    }

    // Context matching score (0.0 - 0.2)
    if (currentContext != null) {
      final contextScore = stats.getContextMatchScore(currentContext);
      probability += contextScore * 0.2;
    }

    // Time pattern score (0.0 - 0.1)
    final timeScore = stats.getTimePatternScore(currentTime);
    probability += timeScore * 0.1;

    return math.min(probability, 1);
  }

  /// Generate reasoning for prediction
  String _generatePredictionReasoning(
    ThemeUsageStats stats,
    ThemeUsageContext? currentContext,
    DateTime currentTime,
  ) {
    final reasons = <String>[];

    if (stats.totalUsages > 10) {
      reasons.add('frequently used (${stats.totalUsages} times)');
    }

    final lastUsed = _lastUsed[stats.themeId];
    if (lastUsed != null) {
      final daysSince = currentTime.difference(lastUsed).inDays;
      if (daysSince < 2) {
        reasons.add('recently used ($daysSince days ago)');
      }
    }

    if (currentContext != null && stats.hasContextPattern(currentContext)) {
      reasons.add('matches current context (${currentContext.name})');
    }

    if (stats.hasTimePattern(currentTime)) {
      reasons.add('matches time pattern');
    }

    return reasons.isEmpty ? 'low usage pattern' : reasons.join(', ');
  }

  /// Start automatic preloading timer
  void _startPreloadTimer(
    Map<String, Future<AppTheme> Function()> themeFactories,
  ) {
    _preloadTimer?.cancel();

    _preloadTimer = Timer.periodic(_preloadInterval, (timer) {
      unawaited(preloadPredictedThemes(themeFactories));
    });
  }

  /// Clean old usage data outside tracking window
  void _cleanOldUsageData() {
    final cutoffTime = DateTime.now().subtract(_usageTrackingWindow);

    _usageStats.removeWhere((themeId, stats) {
      stats.cleanOldData(cutoffTime);
      return stats.totalUsages == 0;
    });

    _lastUsed.removeWhere((themeId, lastUsed) {
      return lastUsed.isBefore(cutoffTime);
    });
  }

  /// Get preloader statistics
  PreloaderStatistics get statistics {
    final totalThemes = _usageStats.length;
    final activeThemes =
        _usageStats.values.where((stats) => stats.totalUsages > 0).length;
    final predictedThemes = predictNextThemes().length;

    return PreloaderStatistics(
      totalTrackedThemes: totalThemes,
      activeThemes: activeThemes,
      recentThemes: _recentThemes.length,
      predictedThemes: predictedThemes,
      cacheHitRate: _cacheManager.statistics.hitRatio,
      isEnabled: _isEnabled,
    );
  }

  /// Enable/disable preloader
  void setEnabled({required bool enabled}) {
    _isEnabled = enabled;

    if (enabled) {
      // Resume preloading if disabled
    } else {
      _preloadTimer?.cancel();
    }
  }

  /// Clear all usage data
  void clearUsageData() {
    _usageStats.clear();
    _lastUsed.clear();
    _recentThemes.clear();
  }

  /// Export usage data for analysis
  Map<String, dynamic> exportUsageData() {
    return {
      'usageStats':
          _usageStats.map((id, stats) => MapEntry(id, stats.toJson())),
      'lastUsed':
          _lastUsed.map((id, time) => MapEntry(id, time.toIso8601String())),
      'recentThemes': _recentThemes,
      'statistics': statistics.toJson(),
    };
  }

  /// Import usage data from previous session
  void importUsageData(Map<String, dynamic> data) {
    try {
      // Import usage statistics
      final usageStatsData = data['usageStats'] as Map<String, dynamic>? ?? {};
      _usageStats.clear();
      for (final entry in usageStatsData.entries) {
        final statsData = entry.value as Map<String, dynamic>;
        _usageStats[entry.key] = ThemeUsageStats.fromJson(statsData);
      }

      // Import last used timestamps
      final lastUsedData = data['lastUsed'] as Map<String, dynamic>? ?? {};
      _lastUsed.clear();
      for (final entry in lastUsedData.entries) {
        final timestamp = entry.value as String;
        _lastUsed[entry.key] = DateTime.parse(timestamp);
      }

      // Import recent themes
      final recentThemesData = data['recentThemes'] as List<dynamic>? ?? [];
      _recentThemes
        ..clear()
        ..addAll(recentThemesData.cast<String>());
    } on Exception catch (e) {
      debugPrint('Failed to import usage data: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _preloadTimer?.cancel();
    _usageStats.clear();
    _lastUsed.clear();
    _recentThemes.clear();
  }
}

/// Theme usage context for better prediction
enum ThemeUsageContext {
  startup('App Startup'),
  settings('Settings Screen'),
  userProfile('User Profile'),
  darkMode('Dark Mode Toggle'),
  lightMode('Light Mode Toggle'),
  systemMode('System Mode'),
  accessibility('Accessibility'),
  branding('Brand Theme'),
  seasonal('Seasonal Theme'),
  timeOfDay('Time-based Theme'),
  userPreference('User Preference'),
  unknown('Unknown Context');

  const ThemeUsageContext(this.displayName);
  final String displayName;
}

/// Theme usage statistics with pattern analysis
class ThemeUsageStats {
  ThemeUsageStats({required this.themeId});

  /// Create from JSON
  factory ThemeUsageStats.fromJson(Map<String, dynamic> json) {
    final themeId = json['themeId'] as String;
    final stats = ThemeUsageStats(themeId: themeId);

    final recordsData = json['usageRecords'] as List<dynamic>? ?? [];
    for (final recordData in recordsData) {
      final recordMap = recordData as Map<String, dynamic>;
      stats._usageRecords.add(ThemeUsageRecord.fromJson(recordMap));
    }

    return stats;
  }
  final String themeId;
  final List<ThemeUsageRecord> _usageRecords = [];

  /// Record a theme usage
  void recordUsage({
    required DateTime timestamp,
    ThemeUsageContext? context,
  }) {
    _usageRecords.add(
      ThemeUsageRecord(
        context: context ?? ThemeUsageContext.unknown,
        timestamp: timestamp,
      ),
    );
  }

  /// Total number of usages
  int get totalUsages => _usageRecords.length;

  /// Get context match score (0.0 - 1.0)
  double getContextMatchScore(ThemeUsageContext context) {
    if (_usageRecords.isEmpty) return 0;

    final contextUsages =
        _usageRecords.where((record) => record.context == context).length;
    return contextUsages / _usageRecords.length;
  }

  /// Check if theme has pattern for given context
  bool hasContextPattern(ThemeUsageContext context) {
    return getContextMatchScore(context) > 0.2; // 20% threshold
  }

  /// Get time pattern score based on hour of day
  double getTimePatternScore(DateTime currentTime) {
    if (_usageRecords.isEmpty) return 0;

    final currentHour = currentTime.hour;
    final hourUsages = _usageRecords.where((record) {
      return (record.timestamp.hour - currentHour).abs() <= 2; // ±2 hours
    }).length;

    return hourUsages / _usageRecords.length;
  }

  /// Check if theme has time-based usage pattern
  bool hasTimePattern(DateTime currentTime) {
    return getTimePatternScore(currentTime) > 0.3; // 30% threshold
  }

  /// Clean usage records older than cutoff time
  void cleanOldData(DateTime cutoffTime) {
    _usageRecords
        .removeWhere((record) => record.timestamp.isBefore(cutoffTime));
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'themeId': themeId,
      'usageRecords': _usageRecords.map((record) => record.toJson()).toList(),
    };
  }
}

/// Individual theme usage record
class ThemeUsageRecord {
  const ThemeUsageRecord({
    required this.context,
    required this.timestamp,
  });

  factory ThemeUsageRecord.fromJson(Map<String, dynamic> json) {
    final contextName = json['context'] as String;
    final timestampStr = json['timestamp'] as String;

    return ThemeUsageRecord(
      context: ThemeUsageContext.values.firstWhere(
        (ctx) => ctx.name == contextName,
        orElse: () => ThemeUsageContext.unknown,
      ),
      timestamp: DateTime.parse(timestampStr),
    );
  }
  final ThemeUsageContext context;
  final DateTime timestamp;

  Map<String, dynamic> toJson() {
    return {
      'context': context.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Theme prediction result
class ThemePrediction {
  const ThemePrediction({
    required this.themeId,
    required this.probability,
    required this.reasoning,
    this.context,
  });
  final String themeId;
  final double probability;
  final ThemeUsageContext? context;
  final String reasoning;

  @override
  String toString() {
    return 'ThemePrediction($themeId: '
        '${(probability * 100).toStringAsFixed(1)}% - $reasoning)';
  }
}

/// Preloader performance statistics
class PreloaderStatistics {
  const PreloaderStatistics({
    required this.totalTrackedThemes,
    required this.activeThemes,
    required this.recentThemes,
    required this.predictedThemes,
    required this.cacheHitRate,
    required this.isEnabled,
  });
  final int totalTrackedThemes;
  final int activeThemes;
  final int recentThemes;
  final int predictedThemes;
  final double cacheHitRate;
  final bool isEnabled;

  Map<String, dynamic> toJson() {
    return {
      'totalTrackedThemes': totalTrackedThemes,
      'activeThemes': activeThemes,
      'recentThemes': recentThemes,
      'predictedThemes': predictedThemes,
      'cacheHitRate': cacheHitRate,
      'isEnabled': isEnabled,
    };
  }

  @override
  String toString() {
    return 'PreloaderStats(tracked: $totalTrackedThemes, '
        'active: $activeThemes, '
        'recent: $recentThemes, predicted: $predictedThemes, '
        'hitRate: ${(cacheHitRate * 100).toStringAsFixed(1)}%, '
        'enabled: $isEnabled)';
  }
}

/// Extension for easy theme usage tracking
extension ThemeUsageTracking on AppTheme {
  /// Track usage of this theme
  void trackUsage({
    ThemeUsageContext? context,
    DateTime? timestamp,
  }) {
    ThemePreloader().trackThemeUsage(
      id,
      context: context,
      timestamp: timestamp,
    );
  }
}
