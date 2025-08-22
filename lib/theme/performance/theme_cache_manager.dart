import 'dart:async';
import 'package:flutter/material.dart';
import '../base/app_theme.dart';

/// High-performance theme cache manager with lazy loading and memory
/// optimization. Implements LRU (Least Recently Used) cache eviction policy
class ThemeCacheManager {
  factory ThemeCacheManager() => _instance;
  ThemeCacheManager._internal();
  static final ThemeCacheManager _instance = ThemeCacheManager._internal();

  // Cache configuration
  static const int _maxCacheSize = 10;
  static const Duration _cacheExpiry = Duration(minutes: 30);
  static const Duration _preloadDelay = Duration(milliseconds: 100);

  // Cache storage
  final Map<String, _CachedTheme> _themeCache = {};
  final Map<String, _CachedThemeData> _themeDataCache = {};
  final List<String> _accessOrder = [];

  // Performance metrics
  int _cacheHits = 0;
  int _cacheMisses = 0;
  int _evictions = 0;

  /// Get theme with caching and lazy loading
  Future<AppTheme?> getTheme(
    String themeId,
    Future<AppTheme> Function() factory,
  ) async {
    final cached = _themeCache[themeId];

    if (cached != null && !cached.isExpired) {
      _updateAccessOrder(themeId);
      _cacheHits++;
      return cached.theme;
    }

    _cacheMisses++;

    // Load theme asynchronously
    final theme = await factory();
    _cacheTheme(themeId, theme);

    return theme;
  }

  /// Get theme data with aggressive caching
  ThemeData? getThemeData(String key, ThemeData Function() factory) {
    final cached = _themeDataCache[key];

    if (cached != null && !cached.isExpired) {
      _updateThemeDataAccessOrder(key);
      _cacheHits++;
      return cached.themeData;
    }

    _cacheMisses++;

    // Create theme data and cache it
    final themeData = factory();
    _cacheThemeData(key, themeData);

    return themeData;
  }

  /// Preload themes for better performance
  Future<void> preloadThemes(
    Map<String, Future<AppTheme> Function()> themeFactories,
  ) async {
    final futures = <Future<void>>[];

    for (final entry in themeFactories.entries) {
      futures.add(_preloadTheme(entry.key, entry.value));
    }

    await Future.wait(futures);
  }

  /// Preload single theme with delay to avoid blocking UI
  Future<void> _preloadTheme(
    String themeId,
    Future<AppTheme> Function() factory,
  ) async {
    await Future<void>.delayed(_preloadDelay);

    if (!_themeCache.containsKey(themeId)) {
      try {
        final theme = await factory();
        _cacheTheme(themeId, theme);
      } on Exception catch (e) {
        debugPrint('Failed to preload theme $themeId: $e');
      }
    }
  }

  /// Cache theme with LRU eviction
  void _cacheTheme(String themeId, AppTheme theme) {
    if (_themeCache.length >= _maxCacheSize) {
      _evictLeastRecentlyUsedTheme();
    }

    _themeCache[themeId] = _CachedTheme(theme);
    _updateAccessOrder(themeId);
  }

  /// Cache theme data with LRU eviction
  void _cacheThemeData(String key, ThemeData themeData) {
    if (_themeDataCache.length >= _maxCacheSize * 2) {
      // Allow more theme data cache
      _evictLeastRecentlyUsedThemeData();
    }

    _themeDataCache[key] = _CachedThemeData(themeData);
  }

  /// Update access order for LRU
  void _updateAccessOrder(String themeId) {
    _accessOrder
      ..remove(themeId)
      ..add(themeId);
  }

  /// Update theme data access order
  void _updateThemeDataAccessOrder(String key) {
    // Simple access tracking for theme data
    final cached = _themeDataCache[key];
    if (cached != null) {
      cached.lastAccessed = DateTime.now();
    }
  }

  /// Evict least recently used theme
  void _evictLeastRecentlyUsedTheme() {
    if (_accessOrder.isNotEmpty) {
      final lruThemeId = _accessOrder.removeAt(0);
      _themeCache.remove(lruThemeId);
      _evictions++;
    }
  }

  /// Evict least recently used theme data
  void _evictLeastRecentlyUsedThemeData() {
    if (_themeDataCache.isNotEmpty) {
      String? oldestKey;
      DateTime? oldestTime;

      for (final entry in _themeDataCache.entries) {
        if (oldestTime == null ||
            entry.value.lastAccessed.isBefore(oldestTime)) {
          oldestTime = entry.value.lastAccessed;
          oldestKey = entry.key;
        }
      }

      if (oldestKey != null) {
        _themeDataCache.remove(oldestKey);
        _evictions++;
      }
    }
  }

  /// Clear expired entries
  void clearExpired() {
    // Clear expired themes
    _themeCache.removeWhere((key, cached) {
      if (cached.isExpired) {
        _accessOrder.remove(key);
        return true;
      }
      return false;
    });

    // Clear expired theme data
    _themeDataCache.removeWhere((key, cached) => cached.isExpired);
  }

  /// Clear all cache
  void clearAll() {
    _themeCache.clear();
    _themeDataCache.clear();
    _accessOrder.clear();
    _resetMetrics();
  }

  /// Get cache statistics
  CacheStatistics get statistics => CacheStatistics(
        cacheHits: _cacheHits,
        cacheMisses: _cacheMisses,
        evictions: _evictions,
        themesCached: _themeCache.length,
        themeDataCached: _themeDataCache.length,
        hitRatio: _cacheHits + _cacheMisses > 0
            ? _cacheHits / (_cacheHits + _cacheMisses)
            : 0.0,
      );

  /// Reset performance metrics
  void _resetMetrics() {
    _cacheHits = 0;
    _cacheMisses = 0;
    _evictions = 0;
  }

  /// Check if theme is cached and valid
  bool isThemeCached(String themeId) {
    final cached = _themeCache[themeId];
    return cached != null && !cached.isExpired;
  }

  /// Check if theme data is cached and valid
  bool isThemeDataCached(String key) {
    final cached = _themeDataCache[key];
    return cached != null && !cached.isExpired;
  }

  /// Get cached theme IDs
  List<String> get cachedThemeIds => _themeCache.keys.toList();

  /// Get memory usage estimation (in bytes)
  int get estimatedMemoryUsage {
    // Rough estimation: each theme ~50KB, each theme data ~30KB
    return (_themeCache.length * 50 * 1024) +
        (_themeDataCache.length * 30 * 1024);
  }
}

/// Cached theme wrapper with expiry
class _CachedTheme {
  _CachedTheme(this.theme) : createdAt = DateTime.now();
  final AppTheme theme;
  final DateTime createdAt;

  bool get isExpired =>
      DateTime.now().difference(createdAt) > ThemeCacheManager._cacheExpiry;
}

/// Cached theme data wrapper with expiry
class _CachedThemeData {
  _CachedThemeData(this.themeData)
      : createdAt = DateTime.now(),
        lastAccessed = DateTime.now();
  final ThemeData themeData;
  final DateTime createdAt;
  DateTime lastAccessed;

  bool get isExpired =>
      DateTime.now().difference(createdAt) > ThemeCacheManager._cacheExpiry;
}

/// Cache performance statistics
class CacheStatistics {
  const CacheStatistics({
    required this.cacheHits,
    required this.cacheMisses,
    required this.evictions,
    required this.themesCached,
    required this.themeDataCached,
    required this.hitRatio,
  });
  final int cacheHits;
  final int cacheMisses;
  final int evictions;
  final int themesCached;
  final int themeDataCached;
  final double hitRatio;

  @override
  String toString() {
    return 'CacheStatistics(hits: $cacheHits, misses: $cacheMisses, '
        'evictions: $evictions, themes: $themesCached, '
        'themeData: $themeDataCached, '
        'hitRatio: ${(hitRatio * 100).toStringAsFixed(1)}%)';
  }
}

/// Mixin for themes to support caching
mixin CacheableTheme on AppTheme {
  static final _cache = ThemeCacheManager();

  /// Get cached light theme data
  ThemeData get cachedLightThemeData {
    final key = '${id}_light';
    return _cache.getThemeData(key, () => lightThemeData) ?? lightThemeData;
  }

  /// Get cached dark theme data
  ThemeData get cachedDarkThemeData {
    final key = '${id}_dark';
    return _cache.getThemeData(key, () => darkThemeData) ?? darkThemeData;
  }

  /// Preload theme data for better performance
  void preloadThemeData() {
    final lightKey = '${id}_light';
    final darkKey = '${id}_dark';

    if (!_cache.isThemeDataCached(lightKey)) {
      _cache.getThemeData(lightKey, () => lightThemeData);
    }

    if (!_cache.isThemeDataCached(darkKey)) {
      _cache.getThemeData(darkKey, () => darkThemeData);
    }
  }
}

/// Extension for performance monitoring
extension ThemeCacheExtensions on ThemeCacheManager {
  /// Monitor cache performance and log warnings
  void monitorPerformance() {
    final stats = statistics;

    if (stats.hitRatio < 0.7) {
      debugPrint(
        'Warning: Low cache hit ratio '
        '(${(stats.hitRatio * 100).toStringAsFixed(1)}%)',
      );
    }

    if (stats.evictions > 50) {
      debugPrint('Warning: High cache eviction count (${stats.evictions})');
    }

    if (estimatedMemoryUsage > 10 * 1024 * 1024) {
      // 10MB
      debugPrint(
        'Warning: High theme cache memory usage '
        '(${(estimatedMemoryUsage / 1024 / 1024).toStringAsFixed(1)}MB)',
      );
    }
  }

  /// Optimize cache by clearing expired entries
  void optimize() {
    clearExpired();
    monitorPerformance();
  }
}
