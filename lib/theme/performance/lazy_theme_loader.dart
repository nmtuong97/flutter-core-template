import 'dart:async';
import 'package:flutter/material.dart';
import '../base/app_theme.dart';
import 'theme_cache_manager.dart';

/// Lazy theme loader with background loading and priority-based scheduling
/// Optimizes app startup time by deferring non-critical theme loading
class LazyThemeLoader {
  factory LazyThemeLoader() => _instance;
  LazyThemeLoader._internal();
  static final LazyThemeLoader _instance = LazyThemeLoader._internal();

  final ThemeCacheManager _cacheManager = ThemeCacheManager();
  final Map<String, _ThemeLoadTask> _loadTasks = {};
  final Map<String, Completer<AppTheme>> _loadingCompleters = {};

  // Loading configuration
  static const Duration _backgroundLoadDelay = Duration(milliseconds: 500);
  static const Duration _highPriorityTimeout = Duration(seconds: 5);
  static const Duration _lowPriorityTimeout = Duration(seconds: 15);

  bool _isInitialized = false;
  Timer? _backgroundLoadTimer;

  /// Initialize lazy loader with essential themes
  Future<void> initialize({
    required List<String> essentialThemeIds,
    required Map<String, Future<AppTheme> Function()> themeFactories,
  }) async {
    if (_isInitialized) return;

    // Load essential themes immediately
    final essentialFutures = <Future<void>>[];
    for (final themeId in essentialThemeIds) {
      final factory = themeFactories[themeId];
      if (factory != null) {
        essentialFutures.add(_loadThemeImmediately(themeId, factory));
      }
    }

    await Future.wait(essentialFutures);

    // Schedule background loading for non-essential themes
    _scheduleBackgroundLoading(themeFactories, essentialThemeIds);

    _isInitialized = true;
  }

  /// Get theme with lazy loading and fallback
  Future<AppTheme> getTheme(
    String themeId,
    Future<AppTheme> Function() factory, {
    ThemeLoadPriority priority = ThemeLoadPriority.normal,
    AppTheme? fallbackTheme,
  }) async {
    // Check cache first
    final cached = await _cacheManager.getTheme(themeId, factory);
    if (cached != null) {
      return cached;
    }

    // Check if already loading
    final existingCompleter = _loadingCompleters[themeId];
    if (existingCompleter != null) {
      return _waitForLoad(existingCompleter, priority, fallbackTheme);
    }

    // Start new load task
    return _startLoadTask(themeId, factory, priority, fallbackTheme);
  }

  /// Load theme immediately (blocking)
  Future<void> _loadThemeImmediately(
    String themeId,
    Future<AppTheme> Function() factory,
  ) async {
    try {
      final theme = await factory();
      await _cacheManager.getTheme(themeId, () async => theme);
    } on Exception catch (e) {
      debugPrint('Failed to load essential theme $themeId: $e');
    }
  }

  /// Start a new load task with priority handling
  Future<AppTheme> _startLoadTask(
    String themeId,
    Future<AppTheme> Function() factory,
    ThemeLoadPriority priority,
    AppTheme? fallbackTheme,
  ) async {
    final completer = Completer<AppTheme>();
    _loadingCompleters[themeId] = completer;

    final task = _ThemeLoadTask(
      themeId: themeId,
      factory: factory,
      priority: priority,
      completer: completer,
      startTime: DateTime.now(),
    );

    _loadTasks[themeId] = task;

    // Execute load based on priority
    switch (priority) {
      case ThemeLoadPriority.high:
        _executeHighPriorityLoad(task, fallbackTheme);
      case ThemeLoadPriority.normal:
        _executeNormalPriorityLoad(task, fallbackTheme);
      case ThemeLoadPriority.low:
        _executeLowPriorityLoad(task, fallbackTheme);
      case ThemeLoadPriority.background:
        _executeBackgroundLoad(task);
    }

    return _waitForLoad(completer, priority, fallbackTheme);
  }

  /// Execute high priority load (immediate)
  void _executeHighPriorityLoad(_ThemeLoadTask task, AppTheme? fallbackTheme) {
    unawaited(_loadThemeWithTimeout(task, _highPriorityTimeout, fallbackTheme));
  }

  /// Execute normal priority load (slight delay)
  void _executeNormalPriorityLoad(
    _ThemeLoadTask task,
    AppTheme? fallbackTheme,
  ) {
    unawaited(
      Future.delayed(const Duration(milliseconds: 50), () {
        return _loadThemeWithTimeout(task, _highPriorityTimeout, fallbackTheme);
      }),
    );
  }

  /// Execute low priority load (longer delay)
  void _executeLowPriorityLoad(_ThemeLoadTask task, AppTheme? fallbackTheme) {
    unawaited(
      Future.delayed(const Duration(milliseconds: 200), () {
        return _loadThemeWithTimeout(task, _lowPriorityTimeout, fallbackTheme);
      }),
    );
  }

  /// Execute background load (no timeout, no fallback)
  void _executeBackgroundLoad(_ThemeLoadTask task) {
    unawaited(
      Future.delayed(const Duration(milliseconds: 1000), () async {
        await _loadTheme(task);
      }),
    );
  }

  /// Load theme with timeout and fallback handling
  Future<void> _loadThemeWithTimeout(
    _ThemeLoadTask task,
    Duration timeout,
    AppTheme? fallbackTheme,
  ) async {
    try {
      final result = await Future.any([
        _loadTheme(task),
        Future.delayed(
          timeout,
          () => throw TimeoutException('Theme load timeout', timeout),
        ),
      ]);

      if (result != null) {
        task.completer.complete(result);
      } else if (fallbackTheme != null) {
        debugPrint('Using fallback theme for ${task.themeId}');
        task.completer.complete(fallbackTheme);
      } else {
        task.completer.completeError('Failed to load theme ${task.themeId}');
      }
    } on Exception catch (e) {
      if (fallbackTheme != null) {
        debugPrint('Theme load failed, using fallback: $e');
        task.completer.complete(fallbackTheme);
      } else {
        task.completer.completeError(e);
      }
    } finally {
      _cleanupTask(task.themeId);
    }
  }

  /// Load theme and cache result
  Future<AppTheme?> _loadTheme(_ThemeLoadTask task) async {
    try {
      final theme = await task.factory();

      // Cache the loaded theme
      await _cacheManager.getTheme(task.themeId, () async => theme);

      return theme;
    } on Exception catch (e) {
      debugPrint('Failed to load theme ${task.themeId}: $e');
      return null;
    }
  }

  /// Wait for load completion with priority-based timeout
  Future<AppTheme> _waitForLoad(
    Completer<AppTheme> completer,
    ThemeLoadPriority priority,
    AppTheme? fallbackTheme,
  ) async {
    final timeout = priority == ThemeLoadPriority.high
        ? _highPriorityTimeout
        : _lowPriorityTimeout;

    try {
      return await completer.future.timeout(timeout);
    } on TimeoutException {
      if (fallbackTheme != null) {
        debugPrint('Theme load timeout, using fallback');
        return fallbackTheme;
      }
      rethrow;
    }
  }

  /// Schedule background loading for non-essential themes
  void _scheduleBackgroundLoading(
    Map<String, Future<AppTheme> Function()> themeFactories,
    List<String> essentialThemeIds,
  ) {
    _backgroundLoadTimer?.cancel();

    _backgroundLoadTimer = Timer(_backgroundLoadDelay, () {
      for (final entry in themeFactories.entries) {
        final themeId = entry.key;
        final factory = entry.value;

        // Skip essential themes (already loaded)
        if (essentialThemeIds.contains(themeId)) continue;

        // Skip if already cached or loading
        if (_cacheManager.isThemeCached(themeId) ||
            _loadingCompleters.containsKey(themeId)) {
          continue;
        }

        // Start background load
        unawaited(
          getTheme(themeId, factory, priority: ThemeLoadPriority.background),
        );
      }
    });
  }

  /// Cleanup completed task
  void _cleanupTask(String themeId) {
    _loadTasks.remove(themeId);
    _loadingCompleters.remove(themeId);
  }

  /// Preload themes based on usage patterns
  Future<void> preloadByUsagePattern({
    required Map<String, Future<AppTheme> Function()> themeFactories,
    required List<String> frequentlyUsedThemes,
    required List<String> recentlyUsedThemes,
  }) async {
    // High priority for frequently used themes
    for (final themeId in frequentlyUsedThemes) {
      final factory = themeFactories[themeId];
      if (factory != null && !_cacheManager.isThemeCached(themeId)) {
        unawaited(getTheme(themeId, factory, priority: ThemeLoadPriority.high));
      }
    }

    // Normal priority for recently used themes
    for (final themeId in recentlyUsedThemes) {
      final factory = themeFactories[themeId];
      if (factory != null && !_cacheManager.isThemeCached(themeId)) {
        unawaited(getTheme(themeId, factory));
      }
    }
  }

  /// Get loading statistics
  LoadingStatistics get statistics {
    final activeTasks = _loadTasks.values.toList();
    final completedTasks =
        activeTasks.where((task) => task.completer.isCompleted).length;

    return LoadingStatistics(
      activeTasks: activeTasks.length,
      completedTasks: completedTasks,
      highPriorityTasks: activeTasks
          .where((task) => task.priority == ThemeLoadPriority.high)
          .length,
      backgroundTasks: activeTasks
          .where((task) => task.priority == ThemeLoadPriority.background)
          .length,
      averageLoadTime: _calculateAverageLoadTime(activeTasks),
    );
  }

  /// Calculate average load time for completed tasks
  Duration _calculateAverageLoadTime(List<_ThemeLoadTask> tasks) {
    final completedTasks =
        tasks.where((task) => task.completer.isCompleted).toList();

    if (completedTasks.isEmpty) return Duration.zero;

    final totalTime = completedTasks.fold<int>(
      0,
      (sum, task) =>
          sum + DateTime.now().difference(task.startTime).inMilliseconds,
    );

    return Duration(milliseconds: totalTime ~/ completedTasks.length);
  }

  /// Cancel all pending loads
  void cancelAllLoads() {
    for (final completer in _loadingCompleters.values) {
      if (!completer.isCompleted) {
        completer.completeError('Load cancelled');
      }
    }

    _loadTasks.clear();
    _loadingCompleters.clear();
    _backgroundLoadTimer?.cancel();
  }

  /// Dispose resources
  void dispose() {
    cancelAllLoads();
    _backgroundLoadTimer?.cancel();
    _isInitialized = false;
  }
}

/// Theme load priority levels
enum ThemeLoadPriority {
  high, // Load immediately, short timeout
  normal, // Load with slight delay, normal timeout
  low, // Load with longer delay, extended timeout
  background, // Load in background, no timeout
}

/// Internal theme load task
class _ThemeLoadTask {
  _ThemeLoadTask({
    required this.themeId,
    required this.factory,
    required this.priority,
    required this.completer,
    required this.startTime,
  });
  final String themeId;
  final Future<AppTheme> Function() factory;
  final ThemeLoadPriority priority;
  final Completer<AppTheme> completer;
  final DateTime startTime;
}

/// Loading performance statistics
class LoadingStatistics {
  const LoadingStatistics({
    required this.activeTasks,
    required this.completedTasks,
    required this.highPriorityTasks,
    required this.backgroundTasks,
    required this.averageLoadTime,
  });
  final int activeTasks;
  final int completedTasks;
  final int highPriorityTasks;
  final int backgroundTasks;
  final Duration averageLoadTime;

  @override
  String toString() {
    return 'LoadingStatistics(active: $activeTasks, '
        'completed: $completedTasks, '
        'highPriority: $highPriorityTasks, background: $backgroundTasks, '
        'avgLoadTime: ${averageLoadTime.inMilliseconds}ms)';
  }
}

/// Mixin for themes to support lazy loading
mixin LazyLoadableTheme on AppTheme {
  static final _loader = LazyThemeLoader();

  /// Load this theme lazily
  Future<AppTheme> loadLazily({
    ThemeLoadPriority priority = ThemeLoadPriority.normal,
    AppTheme? fallbackTheme,
  }) {
    return _loader.getTheme(
      id,
      () async => this,
      priority: priority,
      fallbackTheme: fallbackTheme,
    );
  }
}

/// Extension for theme factories
extension ThemeFactoryExtensions on Map<String, Future<AppTheme> Function()> {
  /// Initialize lazy loading with this factory map
  Future<void> initializeLazyLoading({
    required List<String> essentialThemes,
  }) {
    return LazyThemeLoader().initialize(
      essentialThemeIds: essentialThemes,
      themeFactories: this,
    );
  }
}
