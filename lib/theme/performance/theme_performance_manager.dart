import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../base/app_theme.dart';
import 'lazy_theme_loader.dart';
import 'theme_cache_manager.dart';
import 'theme_preloader.dart';

/// Centralized theme performance manager.
/// Coordinates caching, lazy loading, and preloading for optimal theme
/// performance
class ThemePerformanceManager {
  factory ThemePerformanceManager() => _instance;
  ThemePerformanceManager._internal();
  static final ThemePerformanceManager _instance =
      ThemePerformanceManager._internal();

  final ThemeCacheManager _cacheManager = ThemeCacheManager();
  final LazyThemeLoader _lazyLoader = LazyThemeLoader();
  final ThemePreloader _preloader = ThemePreloader();

  // Theme factories registry
  final Map<String, Future<AppTheme> Function()> _themeFactories = {};

  // Performance configuration
  PerformanceConfig _config = const PerformanceConfig();

  // Performance monitoring
  final List<PerformanceMetric> _performanceHistory = [];
  Timer? _monitoringTimer;

  bool _isInitialized = false;

  /// Initialize performance manager with theme factories and configuration
  Future<void> initialize({
    required Map<String, Future<AppTheme> Function()> themeFactories,
    required List<String> essentialThemes,
    PerformanceConfig? config,
  }) async {
    if (_isInitialized) return;

    _config = config ?? const PerformanceConfig();
    _themeFactories.addAll(themeFactories);

    // Initialize components
    await _lazyLoader.initialize(
      essentialThemeIds: essentialThemes,
      themeFactories: themeFactories,
    );

    _preloader.initialize(themeFactories);

    // Start performance monitoring
    if (_config.enablePerformanceMonitoring) {
      _startPerformanceMonitoring();
    }

    _isInitialized = true;

    debugPrint(
      'ThemePerformanceManager initialized with '
      '${themeFactories.length} themes',
    );
  }

  /// Get theme with full performance optimization
  Future<AppTheme> getTheme(
    String themeId, {
    ThemeLoadPriority priority = ThemeLoadPriority.normal,
    AppTheme? fallbackTheme,
    ThemeUsageContext? context,
  }) async {
    final startTime = DateTime.now();

    try {
      // Track usage for preloader
      if (context != null) {
        _preloader.trackThemeUsage(themeId, context: context);
      }

      // Get theme factory
      final factory = _themeFactories[themeId];
      if (factory == null) {
        throw ThemeNotFoundException('Theme factory not found: $themeId');
      }

      // Load theme with lazy loader (includes caching)
      final theme = await _lazyLoader.getTheme(
        themeId,
        factory,
        priority: priority,
        fallbackTheme: fallbackTheme,
      );

      // Record performance metric
      _recordPerformanceMetric(
        themeId: themeId,
        loadTime: DateTime.now().difference(startTime),
        wasFromCache: _cacheManager.isThemeCached(themeId),
        priority: priority,
      );

      return theme;
    } on Exception catch (e) {
      // Record failed load
      _recordPerformanceMetric(
        themeId: themeId,
        loadTime: DateTime.now().difference(startTime),
        wasFromCache: false,
        priority: priority,
        error: e.toString(),
      );

      rethrow;
    }
  }

  /// Preload themes based on usage patterns
  Future<void> preloadThemes({
    ThemeUsageContext? currentContext,
    List<String>? specificThemes,
  }) async {
    if (!_isInitialized) return;

    if (specificThemes != null) {
      // Preload specific themes
      for (final themeId in specificThemes) {
        final factory = _themeFactories[themeId];
        if (factory != null && !_cacheManager.isThemeCached(themeId)) {
          unawaited(
            _lazyLoader
                .getTheme(
              themeId,
              factory,
              priority: ThemeLoadPriority.background,
            )
                .catchError((dynamic error) {
              debugPrint('Failed to preload theme $themeId: $error');
              return Future<AppTheme>.error(error as Object); // Return error
            }),
          );
        }
      }
    } else {
      // Use intelligent preloading
      await _preloader.preloadPredictedThemes(
        _themeFactories,
        currentContext: currentContext,
      );
    }
  }

  /// Get theme synchronously if cached, null otherwise
  AppTheme? getThemeSync(String themeId) {
    if (!_cacheManager.isThemeCached(themeId)) return null;

    try {
      // This will return immediately if cached
      final factory = _themeFactories[themeId];
      if (factory == null) return null;

      // Use a completer to get cached theme synchronously
      AppTheme? cachedTheme;
      unawaited(
        _cacheManager.getTheme(themeId, factory).then((theme) {
          cachedTheme = theme;
        }).catchError((_) {
          // Ignore errors for sync access
        }),
      );

      return cachedTheme;
    } on Exception catch (_) {
      return null;
    }
  }

  /// Register new theme factory
  void registerThemeFactory(
    String themeId,
    Future<AppTheme> Function() factory,
  ) {
    _themeFactories[themeId] = factory;
  }

  /// Unregister theme factory
  void unregisterThemeFactory(String themeId) {
    _themeFactories.remove(themeId);
  }

  /// Clear all caches
  Future<void> clearCaches() async {
    _cacheManager.clearAll();
    _preloader.clearUsageData();
  }

  /// Optimize performance based on current metrics
  Future<void> optimizePerformance() async {
    final stats = getPerformanceStatistics();

    // Adjust cache size based on hit rate
    if (stats.cacheHitRate < 0.7) {
      // Low hit rate, increase cache size
      debugPrint(
        'Low cache hit rate '
        '(${(stats.cacheHitRate * 100).toStringAsFixed(1)}%), '
        'consider increasing cache size',
      );
    }

    // Preload frequently used themes
    final frequentThemes = _getFrequentlyUsedThemes();
    if (frequentThemes.isNotEmpty) {
      await preloadThemes(specificThemes: frequentThemes);
    }

    // Clean up old performance data
    _cleanOldPerformanceData();
  }

  /// Get comprehensive performance statistics
  PerformanceStatistics getPerformanceStatistics() {
    final cacheStats = _cacheManager.statistics;
    final loaderStats = _lazyLoader.statistics;
    final preloaderStats = _preloader.statistics;

    final recentMetrics = _getRecentMetrics();
    final averageLoadTime = _calculateAverageLoadTime(recentMetrics);
    final errorRate = _calculateErrorRate(recentMetrics);

    return PerformanceStatistics(
      cacheHitRate: cacheStats.hitRatio,
      averageLoadTime: averageLoadTime,
      errorRate: errorRate,
      totalThemesLoaded: recentMetrics.length,
      cacheSize: cacheStats.themesCached,
      activeLoadTasks: loaderStats.activeTasks,
      predictedThemes: preloaderStats.predictedThemes,
      memoryUsage: _cacheManager.estimatedMemoryUsage,
    );
  }

  /// Record performance metric
  void _recordPerformanceMetric({
    required String themeId,
    required Duration loadTime,
    required bool wasFromCache,
    required ThemeLoadPriority priority,
    String? error,
  }) {
    final metric = PerformanceMetric(
      themeId: themeId,
      loadTime: loadTime,
      wasFromCache: wasFromCache,
      priority: priority,
      timestamp: DateTime.now(),
      error: error,
    );

    _performanceHistory.add(metric);

    // Keep only recent metrics
    if (_performanceHistory.length > _config.maxPerformanceHistory) {
      _performanceHistory.removeAt(0);
    }
  }

  /// Start performance monitoring timer
  void _startPerformanceMonitoring() {
    _monitoringTimer?.cancel();

    _monitoringTimer = Timer.periodic(_config.monitoringInterval, (timer) {
      final stats = getPerformanceStatistics();

      // Log performance warnings
      if (stats.cacheHitRate < 0.5) {
        debugPrint(
          'Warning: Low cache hit rate: '
          '${(stats.cacheHitRate * 100).toStringAsFixed(1)}%',
        );
      }

      if (stats.averageLoadTime.inMilliseconds > 1000) {
        debugPrint(
          'Warning: High average load time: '
          '${stats.averageLoadTime.inMilliseconds}ms',
        );
      }

      if (stats.errorRate > 0.1) {
        debugPrint(
          'Warning: High error rate: '
          '${(stats.errorRate * 100).toStringAsFixed(1)}%',
        );
      }
    });
  }

  /// Get frequently used themes
  List<String> _getFrequentlyUsedThemes() {
    final themeUsage = <String, int>{};

    for (final metric in _getRecentMetrics()) {
      themeUsage[metric.themeId] = (themeUsage[metric.themeId] ?? 0) + 1;
    }

    final sortedThemes = themeUsage.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedThemes.take(5).map((e) => e.key).toList();
  }

  /// Get recent performance metrics
  List<PerformanceMetric> _getRecentMetrics() {
    final cutoff = DateTime.now().subtract(_config.metricsRetentionPeriod);
    return _performanceHistory
        .where((metric) => metric.timestamp.isAfter(cutoff))
        .toList();
  }

  /// Calculate average load time from metrics
  Duration _calculateAverageLoadTime(List<PerformanceMetric> metrics) {
    if (metrics.isEmpty) return Duration.zero;

    final totalMs = metrics.fold<int>(
      0,
      (sum, metric) => sum + metric.loadTime.inMilliseconds,
    );

    return Duration(milliseconds: totalMs ~/ metrics.length);
  }

  /// Calculate error rate from metrics
  double _calculateErrorRate(List<PerformanceMetric> metrics) {
    if (metrics.isEmpty) return 0;

    final errorCount = metrics.where((metric) => metric.error != null).length;
    return errorCount / metrics.length;
  }

  /// Clean old performance data
  void _cleanOldPerformanceData() {
    final cutoff = DateTime.now().subtract(_config.metricsRetentionPeriod);
    _performanceHistory
        .removeWhere((metric) => metric.timestamp.isBefore(cutoff));
  }

  /// Update performance configuration
  void updateConfig(PerformanceConfig config) {
    _config = config;

    if (config.enablePerformanceMonitoring && _monitoringTimer == null) {
      _startPerformanceMonitoring();
    } else if (!config.enablePerformanceMonitoring &&
        _monitoringTimer != null) {
      _monitoringTimer?.cancel();
      _monitoringTimer = null;
    }
  }

  /// Export performance data for analysis
  Map<String, dynamic> exportPerformanceData() {
    return {
      'statistics': getPerformanceStatistics().toJson(),
      'recentMetrics': _getRecentMetrics().map((m) => m.toJson()).toList(),
      'themeFactories': _themeFactories.keys.toList(),
      'config': _config.toJson(),
      'preloaderData': _preloader.exportUsageData(),
    };
  }

  /// Dispose resources
  void dispose() {
    _monitoringTimer?.cancel();
    _lazyLoader.dispose();
    _preloader.dispose();
    _performanceHistory.clear();
    _themeFactories.clear();
    _isInitialized = false;
  }
}

/// Performance configuration
class PerformanceConfig {
  const PerformanceConfig({
    this.enablePerformanceMonitoring = true,
    this.monitoringInterval = const Duration(minutes: 1),
    this.metricsRetentionPeriod = const Duration(hours: 24),
    this.maxPerformanceHistory = 1000,
    this.enablePreloading = true,
    this.enableLazyLoading = true,
  });
  final bool enablePerformanceMonitoring;
  final Duration monitoringInterval;
  final Duration metricsRetentionPeriod;
  final int maxPerformanceHistory;
  final bool enablePreloading;
  final bool enableLazyLoading;

  Map<String, dynamic> toJson() {
    return {
      'enablePerformanceMonitoring': enablePerformanceMonitoring,
      'monitoringInterval': monitoringInterval.inMilliseconds,
      'metricsRetentionPeriod': metricsRetentionPeriod.inMilliseconds,
      'maxPerformanceHistory': maxPerformanceHistory,
      'enablePreloading': enablePreloading,
      'enableLazyLoading': enableLazyLoading,
    };
  }
}

/// Individual performance metric
class PerformanceMetric {
  const PerformanceMetric({
    required this.themeId,
    required this.loadTime,
    required this.wasFromCache,
    required this.priority,
    required this.timestamp,
    this.error,
  });
  final String themeId;
  final Duration loadTime;
  final bool wasFromCache;
  final ThemeLoadPriority priority;
  final DateTime timestamp;
  final String? error;

  Map<String, dynamic> toJson() {
    return {
      'themeId': themeId,
      'loadTime': loadTime.inMilliseconds,
      'wasFromCache': wasFromCache,
      'priority': priority.name,
      'timestamp': timestamp.toIso8601String(),
      'error': error,
    };
  }
}

/// Comprehensive performance statistics
class PerformanceStatistics {
  const PerformanceStatistics({
    required this.cacheHitRate,
    required this.averageLoadTime,
    required this.errorRate,
    required this.totalThemesLoaded,
    required this.cacheSize,
    required this.activeLoadTasks,
    required this.predictedThemes,
    required this.memoryUsage,
  });
  final double cacheHitRate;
  final Duration averageLoadTime;
  final double errorRate;
  final int totalThemesLoaded;
  final int cacheSize;
  final int activeLoadTasks;
  final int predictedThemes;
  final int memoryUsage;

  Map<String, dynamic> toJson() {
    return {
      'cacheHitRate': cacheHitRate,
      'averageLoadTime': averageLoadTime.inMilliseconds,
      'errorRate': errorRate,
      'totalThemesLoaded': totalThemesLoaded,
      'cacheSize': cacheSize,
      'activeLoadTasks': activeLoadTasks,
      'predictedThemes': predictedThemes,
      'memoryUsage': memoryUsage,
    };
  }

  @override
  String toString() {
    return 'PerformanceStats(hitRate: '
        '${(cacheHitRate * 100).toStringAsFixed(1)}%, '
        'avgLoad: ${averageLoadTime.inMilliseconds}ms, '
        'errorRate: ${(errorRate * 100).toStringAsFixed(1)}%, '
        'cached: $cacheSize, '
        'memory: ${(memoryUsage / 1024 / 1024).toStringAsFixed(1)}MB)';
  }
}

/// Theme not found exception
class ThemeNotFoundException implements Exception {
  const ThemeNotFoundException(this.message);
  final String message;

  @override
  String toString() => 'ThemeNotFoundException: $message';
}

/// Extension for easy performance manager access
extension ThemePerformanceExtensions on AppTheme {
  /// Load this theme with performance optimization
  Future<AppTheme> loadOptimized({
    ThemeLoadPriority priority = ThemeLoadPriority.normal,
    AppTheme? fallbackTheme,
    ThemeUsageContext? context,
  }) {
    return ThemePerformanceManager().getTheme(
      id,
      priority: priority,
      fallbackTheme: fallbackTheme,
      context: context,
    );
  }
}
