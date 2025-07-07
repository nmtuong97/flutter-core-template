import 'package:flutter/material.dart';

/// Các hằng số chung của ứng dụng
class AppConstants {
  // Private constructor để ngăn việc khởi tạo instance
  AppConstants._();

  // Video Constants
  static const double landscapeVideoAspectRatio = 16 / 9;
  static const double portraitVideoAspectRatio = 9 / 16;
  static const double squareAspectRatio = 1.0;
  static const double landscapeAspectRatioThreshold = 1.2;
  static const double portraitAspectRatioThreshold = 0.8;
  static const int videoSeekSeconds = 10;
  static const bool videoPlayerMixWithOthers = false;
  static const bool videoPlayerAllowBackgroundPlayback = false;
  static const int videoInitializationTimeoutSeconds = 30;
  static const int controlsHideDelaySeconds = 3;
  static const int seekForwardSeconds = 10;
  static const int seekBackwardSeconds = 10;
  static const String defaultUserAgent = 'Playdo Video Player';
  static const int videoThumbnailSeekMilliseconds = 500;
  static const int videoThumbnailQuality = 50;
  static const int videoThumbnailMaxWidth = 300;

  // Chewie Player Constants
  static const bool chewieAutoPlay = true;
  static const bool chewieLooping = false;
  static const bool chewieAllowFullScreen = true;
  static const bool chewieAllowMuting = true;
  static const bool chewieAllowPlaybackSpeedChanging = true;
  static const bool chewieShowControls = true;
  static const bool chewieAutoInitialize = true;
  static const double progressBackgroundOpacity = 0.3;
  static const double progressBufferedOpacity = 0.6;

  // Video Player UI Constants
  static const double playButtonSize = 80.0;
  static const double controlButtonSize = 40.0;
  static const double playButtonOpacity = 0.8;
  static const double controlButtonOpacity = 0.8;
  static const double overlayOpacity = 0.7;
  static const double subtitleOpacity = 0.7;

  // Slider Constants
  static const double sliderThumbRadius = 8.0;
  static const double sliderOverlayRadius = 16.0;
  static const double sliderTrackHeight = 4.0;
  static const double sliderInactiveOpacity = 0.3;
  static const double sliderOverlayOpacity = 0.2;

  // Volume Control Constants
  static const double volumeSliderHeight = 200.0;
  static const double volumeSliderWidth = 60.0;
  static const double volumeSliderHiddenOffset = 200.0;
  static const double volumeSliderTopRatio = 0.3;
  static const double volumeSliderBackgroundOpacity = 0.8;
  static const double volumeSliderBorderRadius = 30.0;
  static const double volumeControlHeight = 40.0;

  // Large Video Handler Constants
  static const int largeVideoSizeMB = 100;
  static const int estimatedVideoSecondsPerMB = 10;
  static const int defaultVideoDurationSeconds = 60;
  static const int maxRetryAttempts = 3;
  static const int retryDelaySeconds = 2;
  static const int maxStackTraceLines = 10;

  // UI Constants
  static const double defaultButtonHeight = 48.0;
  static const double defaultBorderRadius = 12.0;
  static const double borderRadiusSmall = 8.0;
  static const double defaultIconSize = 24.0;
  static const double largeIconSize = 40.0;
  static const double smallIconSize = 16.0;
  static const double iconSizeSmall = 16.0;
  static const double errorIconSize = 48.0;

  // Font Size Constants
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 18.0;

  // Padding and Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double paddingMedium = 16.0;
  static const double paddingSmall = 8.0;
  static const double paddingTiny = 4.0;
  static const double paddingLarge = 24.0;
  static const double defaultSpacing = 16.0;
  static const double smallSpacing = 8.0;

  // Font Weights
  static const FontWeight normalFontWeight = FontWeight.w500;
  static const FontWeight boldFontWeight = FontWeight.w600;

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  static const Duration shimmerAnimationDuration = Duration(milliseconds: 1500);

  // Cache and Performance
  static const int defaultPageSize = 20;
  static const int maxCacheSize = 100;
  static const int defaultItemHeight = 80;
  static const int defaultItemCount = 10;

  // File Size Constants
  static const int bytesPerKB = 1024;
  static const int bytesPerMB = 1024 * 1024;
  static const int bytesPerGB = 1024 * 1024 * 1024;
  static const double bytesToMB = 1024 * 1024;

  // Time Format Constants
  static const int secondsPerMinute = 60;
  static const int minutesPerHour = 60;
  static const String timeFormatPadding = '0';
  static const int timeFormatWidth = 2;

  // Screen Size Breakpoints
  static const double tabletBreakpoint = 600.0;
  static const double smallScreenBreakpoint = 400.0;

  // Volume Control
  static const double defaultVolume = 1.0;
  static const double minVolume = 0.0;
  static const double maxVolume = 1.0;
  static const double volumeControlSliderHeight = 120.0;

  // Grid and List Constants
  static const double defaultCrossAxisSpacing = 16.0;
  static const double defaultMainAxisSpacing = 16.0;
  static const double cardHeight = 160.0;
  static const double cardWidth = 240.0;

  // Permission and Error Handling
  static const int permissionCheckTimeoutSeconds = 5;

  // Debug and Sample Data
  static const int sampleVideoCount = 15;
  static const int maxRandomValue = 10000;
  static const int maxRandomDays = 30;
  static const int maxRandomSizeMB = 100;

  // Network and URL Constants
  static const String httpPrefix = 'http';
  static const String httpsPrefix = 'https';
  static const String filePrefix = 'file://';
  static const String contentPrefix = 'content://';

  // Default Values
  static const String defaultVideoTitle = 'Video';
  static const String defaultVideoPlayerTitle = 'Video Player';
  static const String defaultFileExtension = 'VIDEO';

  // Sample URLs
  static const String sampleVideoUrl =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
  static const String sampleVideoTitle = 'Big Buck Bunny';

  // Navigation Constants
  static const String routeHome = '/';
  static const String routeEnhancedVideo = 'enhanced_video';
  static const int navigationDelayMs = 100;
  static const int navigationRetryDelayMs = 300;

  // Cache Constants
  static const int cacheMaxAgeMinutes = 5;
  static const int cacheMaxSize = 100;
  static const bool diskCacheEnabled = true;
  static const int cacheMinSize = 10;
  static const int cacheMaxSizeLimit = 1000;
}
