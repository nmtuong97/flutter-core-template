/// Các chuỗi văn bản cố định trong ứng dụng
/// Tập trung quản lý để dễ dàng bảo trì và đa ngôn ngữ
class AppStrings {
  // Private constructor để ngăn việc khởi tạo instance
  AppStrings._();

  // Error Messages
  static const String errorGeneral = 'Đã xảy ra lỗi';
  static const String errorNetwork = 'Lỗi kết nối mạng';
  static const String errorFileNotFound = 'Không tìm thấy file';
  static const String errorPermissionDenied = 'Không có quyền truy cập';
  static const String errorVideoPlayback = 'Lỗi phát video';
  static const String errorVideoFormat = 'Định dạng video không được hỗ trợ';
  static const String errorVideoCorrupted = 'Video bị hỏng';
  static const String errorVideoTooLarge = 'Video quá lớn';
  static const String errorCacheWrite = 'Lỗi ghi cache';
  static const String errorCacheRead = 'Lỗi đọc cache';
  static const String errorThumbnailGeneration = 'Lỗi tạo thumbnail';
  static const String errorVideoFileNotFound = 'Video file not found';
  static const String errorVideoInitializationTimeout =
      'Video initialization timed out after';
  static const String errorLabel = 'Lỗi';
  static const String errorCannotCreateController =
      'Không thể tạo controller cho video';
  static const String errorCannotInitializeController =
      'Không thể khởi tạo controller sau nhiều lần thử';
  static const String errorCannotPlayVideo = 'Không thể phát video';
  static const String errorFileNotExists = 'File không tồn tại';
  static const String errorFileNotExistsAt = 'File không tồn tại tại';
  static const String errorCannotAccessFile =
      'File does not exist or cannot be accessed';
  static const String errorVideoInitialization =
      'ERROR INITIALIZING VIDEO PLAYER';
  static const String errorVideoInitializationGeneric =
      'ERROR initializing video';
  static const String errorDisposingController = 'Error disposing controller';
  static const String errorDisposingVideoController =
      'Error disposing video controller';
  static const String errorDisposingChewieController =
      'Error disposing chewie controller';
  static const String errorLoadingThumbnail = 'Error loading thumbnail';
  static const String errorInitializingVideoController =
      'Error initializing video controller';
  static const String errorCreatingVideoController =
      'Error creating video controller';
  static const String errorInitializingVideo = 'Error initializing video';
  static const String errorCreatingController = 'Error creating controller';
  static const String errorInitializingController =
      'Error initializing controller';
  static const String errorInitializingPlayer = 'Error initializing player';
  static const String errorLoadingVideos = 'Error loading videos';
  static const String errorPickingVideos = 'Error picking videos';
  static const String errorInDeviceVideoFromXFile =
      'Error in DeviceVideo.fromXFile';
  static const String errorCheckingPermission = 'Error checking permission';
  static const String errorRequestingPermission = 'Error requesting permission';
  static const String errorScanningForVideos = 'Error scanning for videos';
  static const String errorScanningDirectory = 'Error scanning directory';
  static const String errorCheckingVideoSize = 'Error checking video size';
  static const String errorGettingFileSize = 'Error getting file size';
  static const String errorEstimatingDuration =
      'Error estimating duration from file size';
  static const String errorDuringPlayPause = 'Error during play/pause';
  static const String errorExtractingVideoTitle =
      'Error extracting video title';
  static const String errorExtractingTitleFromUrl =
      'Error extracting title from URL';
  static const String errorNavigatingToVideoPlayer =
      'Error navigating to video player';
  static const String errorGettingVideoIntent = 'Error getting video intent';
  static const String errorCheckingPendingIntent =
      'Error checking pending intent';
  static const String errorOpeningManageAllFilesSettings =
      'Error opening manage all files settings';
  static const String errorCheckingManageAllFilesPermission =
      'Error checking manage all files permission';
  static const String errorDetectingVideoOrientation =
      'Error detecting video orientation';
  static const String errorDetectingVideoOrientationFromPath =
      'Error detecting video orientation from path';
  static const String errorExtractingVideoResolution =
      'Error extracting video resolution';
  static const String errorCreatingCacheDirectory =
      'Error creating cache directory';
  static const String errorSavingThumbnailToDisk =
      'Error saving thumbnail to disk';
  static const String errorLoadingThumbnailFromDisk =
      'Error loading thumbnail from disk';
  static const String errorGeneratingThumbnail = 'Error generating thumbnail';
  static const String errorCleaningUpDiskCache = 'Error cleaning up disk cache';
  static const String errorClearingDiskCache = 'Error clearing disk cache';
  static const String errorPlayingWithSystemIntent =
      'Error playing with system intent';
  static const String errorGettingPathFromController =
      'Error getting path from controller';
  static const String errorCreatingChewieController =
      'Error creating ChewieController';
  static const String errorInAddDebugVideos = 'Error in _addDebugVideos';
  static const String errorAccessingDownloadDirectory =
      'Error accessing Download directory';
  static const String errorInLoadVideos = 'Error in _loadVideos';
  static const String errorInPickVideos = 'Error in _pickVideos';
  static const String errorCheckingForVideoIntent =
      'Error checking for video intent';
  static const String errorExtractingTitleFromURL =
      'Error extracting title from URL';
  static const String errorSavingVideoPosition = 'Lỗi khi lưu vị trí video';
  static const String errorLoadingSavedVideoPosition =
      'Lỗi khi lấy vị trí video đã lưu';
  static const String errorLoadingVideoInfo = 'Lỗi khi tải thông tin video';

  // Success Messages
  static const String videoLoadedSuccessfully = 'Video loaded successfully';
  static const String videoInitializedSuccessfully =
      'Video initialized successfully';
  static const String controllerInitializedSuccessfully =
      'Controller initialized successfully';
  static const String fileExists = 'File exists';
  static const String canAccessDownloadDirectory =
      'Can access Download directory, permission granted';
  static const String photosAndVideosPermissionsGranted =
      'Photos and Videos permissions granted';
  static const String manageExternalStoragePermissionGranted =
      'MANAGE_EXTERNAL_STORAGE permission granted';
  static const String openedManageAllFilesSettings =
      'Opened manage all files settings';
  static const String successfullyListedDirectory =
      'Successfully listed directory, found';
  static const String permissionGranted = 'Permission granted';
  static const String permissionCheckTimedOut =
      'Permission check timed out after 5 seconds';
  static const String addedDebugVideos = 'Added debug videos';
  static const String createdSampleVideo = 'Created sample video';
  static const String gotDebugVideos = 'Got debug videos';
  static const String totalDebugVideos = 'Total debug videos';
  static const String foundVideo = 'Found video';
  static const String foundVideosOnDevice = 'Found videos on device';
  static const String scanningFolder = 'Scanning folder';
  static const String foundFilesInFolder = 'Found files/folders in';
  static const String startingGetVideos = 'Starting getVideos()';
  static const String scanningDeviceForVideos = 'Scanning device for videos';
  static const String androidSdkVersion = 'Android SDK version';
  static const String storagePermissionRequestResult =
      'Storage permission request result';
  static const String photosPermissionRequestResult =
      'Photos permission request result';
  static const String videosPermissionRequestResult =
      'Videos permission request result';
  static const String android11RequestingManageExternalStorage =
      'Android 11+, requesting MANAGE_EXTERNAL_STORAGE';
  static const String requestingPermissionsUsingPermissionHandler =
      'Requesting permissions using permission_handler';
  static const String checkingPermissionsUsingPermissionHandler =
      'Checking permissions using permission_handler';
  static const String manageExternalStoragePermission =
      'MANAGE_EXTERNAL_STORAGE permission';
  static const String storagePermissionStatus = 'Storage permission status';
  static const String photosPermissionStatus = 'Photos permission status';
  static const String videosPermissionStatus = 'Videos permission status';
  static const String downloadDirectoryExists = 'Download directory exists';
  static const String canListDownloadDirectory = 'can list';
  static const String permissionStatus = 'Permission status';
  static const String permissionNotGranted =
      'Permission not granted, returning empty list';
  static const String returningEmptyListFromGetVideos =
      'Returning empty list from getVideos()';
  static const String creatingSampleVideosForDebugging =
      'Creating sample videos for debugging';
  static const String directoryDoesNotExist = 'Directory does not exist';
  static const String cannotListDirectory = 'Cannot list directory';
  static const String permissionPermanentlyDenied =
      'Permission permanently denied';
  static const String permissionDenied = 'Permission denied';
  static const String permissionDeniedByDefault =
      'Permission denied by default';
  static const String intentHandlingInitialized = 'Intent handling initialized';
  static const String receivedIntentData = 'Received intent data';
  static const String appDocumentsDirectory = 'App documents directory';
  static const String initializingIntentChannelService =
      'Initializing IntentChannelService';
  static const String receivedMethodCall = 'Received method call';
  static const String receivedVideoIntent = 'Received video intent';
  static const String receivedVideoIntentError = 'Received video intent error';
  static const String unknownMethod = 'Unknown method';
  static const String processingVideoPath = 'Processing video path';
  static const String splitPathFromSeparator =
      'Split path from | separator, using';
  static const String usingContentUriAsIs = 'Using content:// URI as is';
  static const String fileExistsAtAbsolutePath = 'File exists at absolute path';
  static const String fileDoesNotExistAtAbsolutePath =
      'File does not exist at absolute path';
  static const String tryingWithFilePrefixOnIos =
      'Trying with file:// prefix on iOS';
  static const String removedFilePrefixOnIos = 'Removed file:// prefix on iOS';
  static const String tryingWithFilePrefix = 'Trying with file:// prefix';
  static const String handlingVideoIntentWithUrl =
      'Handling video intent with URL';
  static const String routingToEnhancedVideoPlayerWithUrl =
      'Routing to enhanced video player with URL';
  static const String detectedDirectUriFromIntent =
      'Detected direct URI from intent - redirecting to home';
  static const String openingEnhancedVideoPlayerWithUrl =
      'Opening enhanced video player with URL';

  // Debug Messages
  static const String debugPrefix = 'DEBUG:';

  static const String debugProcessingVideoUrl = 'Processing video URL';
  static const String debugFileCheckResult = 'File check result';
  static const String debugTryingWithOriginalUrl = 'Trying with original URL';

  static const String debugDetectedOrientation = 'Detected orientation';

  static const String debugAnalyzingVideoPath = 'DEBUG: Analyzing video path';
  static const String debugInitialOrientationPrediction =
      'DEBUG: Initial orientation prediction';
  static const String debugControllerInitialized =
      'DEBUG: Controller initialized';
  static const String debugVideoSize = 'DEBUG: Video size';
  static const String debugVideoDuration = 'DEBUG: Video duration';
  static const String debugVideoPosition = 'DEBUG: Video position';
  static const String debugHasError = 'DEBUG: Has error';
  static const String debugErrorDescription = 'DEBUG: Error description';
  static const String debugActualVideoAspectRatio =
      'DEBUG: Actual video aspectRatio';
  static const String debugAdjustingScreenOrientation =
      'DEBUG: Adjusting screen orientation. isPortraitVideo';
  static const String debugSettingPortraitOrientation =
      'DEBUG: Setting PORTRAIT orientation';
  static const String debugSettingLandscapeOrientation =
      'DEBUG: Setting LANDSCAPE orientation';

  // Enhanced Video Player Debug Messages
  static const String debugVideoPlayerPageInit =
      'EnhancedVideoPlayerPage: initState called';
  static const String debugVideoPlayerPageDispose =
      'EnhancedVideoPlayerPage: dispose called';
  static const String debugInitializingPlayer = 'Initializing video player for';
  static const String debugVideoFileNotExist = 'Video file does not exist';
  static const String debugErrorDisposingVideoController =
      'DEBUG: Error disposing video controller';
  static const String debugErrorDisposingChewieController =
      'DEBUG: Error disposing chewie controller';
  static const String debugProcessedVideoUrl = 'Processed video URL';
  static const String debugDetectedLargeVideo =
      'Detected large video file, using optimized settings';
  static const String debugErrorCheckingVideoSize = 'Error checking video size';
  static const String debugInitializingNetworkPlayer =
      'Initializing network video player with URL';
  static const String debugInitializingContentUriPlayer =
      'Initializing content URI video player';
  static const String debugInitializingFilePlayer =
      'Initializing file video player';
  static const String debugFileNotExistOrCannotAccess =
      'File does not exist or cannot be accessed';
  static const String debugErrorDetail = 'Error detail';
  static const String debugTryingOriginalUrl = 'Trying with original URL';
  static const String debugVideoFileSize = 'Video file size';
  static const String debugUsingReducedBufferSize =
      'Using reduced buffer size for large video';
  static const String debugStackTrace = 'Stack trace';
  static const String debugErrorInitializingVideoPlayer =
      'ERROR INITIALIZING VIDEO PLAYER';
  static const String debugVideoLoadedSuccessfully =
      'Video loaded successfully';
  static const String debugStartingDeviceVideoFromXFile =
      'Starting DeviceVideo.fromXFile() with path';
  static const String debugXFilePath = 'XFile path';
  static const String debugErrorDetectingVideoOrientation =
      'Error detecting video orientation';
  static const String debugErrorDetectingVideoOrientationFromPath =
      'Error detecting video orientation from path';

  // Large Video Handler Debug Messages
  static const String debugFileExists = 'DEBUG: File exists, size';
  static const String debugCanRead = 'can read';
  static const String debugUsingOptimizedSettings =
      'Using optimized settings for large video';
  static const String debugStartingVideoInitialization =
      'DEBUG: Starting video initialization with timeout';
  static const String debugVideoInitializationTimedOut =
      'DEBUG: Video initialization TIMED OUT after';
  static const String debugVideoInitializedSuccessfully =
      'DEBUG: Video initialized successfully';
  static const String debugErrorDisposingController =
      'Error disposing controller';

  static const String debugExtractedTitle = 'Extracted title';
  static const String debugCreatedFileObject = 'Created File object, exists';
  static const String debugFileSize = 'File size';
  static const String debugFileDoesNotExistAtPath2 =
      'File does not exist at path';
  static const String debugUsingCurrentTimeForCreateDate =
      'Using current time for createDate';
  static const String debugCreatingDeviceVideoObject =
      'Creating DeviceVideo object';
  static const String debugSuccessfullyCreatedDeviceVideoObject =
      'Successfully created DeviceVideo object';
  static const String debugDeviceVideosGridInitStateCalled =
      'DeviceVideosGrid initState called';
  static const String debugPickVideosGotVideos = '_pickVideos got videos';
  static const String debugStartingLoadVideos = 'Starting _loadVideos()';
  static const String debugAlreadyLoading = 'Already loading, returning';
  static const String debugSettingIsLoadingTrue = 'Setting _isLoading = true';
  static const String debugCallingDeviceVideosServiceGetVideos =
      'Calling DeviceVideosService.getVideos()';
  static const String debugDeviceVideosServiceGetVideosReturned =
      'DeviceVideosService.getVideos() returned videos';
  static const String debugWidgetIsStillMounted =
      'Widget is still mounted, updating state';
  static const String debugWidgetIsNoLongerMounted =
      'Widget is no longer mounted';
  static const String debugWidgetIsStillMountedAfterError =
      'Widget is still mounted, updating state after error';
  static const String debugWidgetIsNoLongerMountedAfterError =
      'Widget is no longer mounted after error';
  static const String debugStartingRefreshVideos = 'Starting _refreshVideos()';
  static const String debugBuildingDeviceVideosGridWidget =
      'Building DeviceVideosGrid widget';
  static const String debugCurrentState = 'Current state: videos=';

  static const String debugCallingDeviceVideosServiceCheckPermission =
      'Calling DeviceVideosService.checkPermission()';
  static const String debugUpdatingStateWithPermissionStatus =
      'Updating state with permission status';
  static const String debugSettingPermissionStatusToDeniedDueToError =
      'Setting permission status to denied due to error';
  static const String debugBuildingLibraryTab =
      'Building library tab, isCheckingPermission';
  static const String debugInitializingVideoControllerForPath =
      'Initializing video controller for path';
  static const String debugIsUrl = 'Is URL';
  static const String debugCreatingNetworkController =
      'Creating network controller';
  static const String debugCheckingIfFileExists = 'Checking if file exists';
  static const String debugFileDoesNotExistShowingErrorState =
      'File does not exist, showing error state';
  static const String debugCreatingFileController = 'Creating file controller';
  static const String debugInitializingController = 'Initializing controller';
  static const String debugVideoDurationFromController =
      'Video duration from controller';
  static const String debugFailedToGetDuration = 'Failed to get duration for';
  static const String debugAfterPlayPauseDuration =
      'After play/pause, duration';
  static const String debugStillZeroDurationAfterPlayPause =
      'Still zero duration after play/pause';
  static const String debugEstimatedDurationFromFileSize =
      'Estimated duration from file size';
  static const String debugBuildingWidgetWithDuration =
      'Building widget with duration';
  static const String debugFileCheckResultColon = 'File check result:';
  static const String debugFileDoesNotExistOrCannotBeAccessed =
      'File does not exist or cannot be accessed';
  static const String debugUsingOptimizedSettingsForLargeVideo =
      'Using optimized settings for large video';
  static const String debugStartingVideoInitializationWithTimeout =
      'Starting video initialization with timeout';
  static const String debugUsingReducedBufferSizeForLargeVideo =
      'Using reduced buffer size for large video';

  // Default Values
  static const String defaultVideoTitle = 'Video';
  static const String defaultErrorMessage = 'Đã xảy ra lỗi';

  // UI Labels and Texts
  static const String videoTitle = 'Video';
  static const String videoPlayerTitle = 'Video Player';
  static const String videoInfo = 'Thông tin video';
  static const String videoInfoWhite = 'Thông tin video';
  static const String close = 'Đóng';
  static const String back = 'Quay lại';
  static const String retry = 'Thử lại';

  // Time Units
  static const String timeUnitSeconds = 'seconds';

  // UI Labels
  static const String buttonGoBack = 'Quay lại';
  static const String buttonRetry = 'Thử lại';
  static const String labelLoading = 'Đang tải video...';
  static const String labelVideoError =
      'Không thể phát video. Video có thể quá lớn hoặc bị hỏng.';
  static const String labelPortraitVideo = 'Video dạng đứng';
  static const String labelLandscapeVideo = 'Video dạng ngang';
  static const String refresh = 'Refresh';
  static const String debug = 'Debug';
  static const String addToPlaylist = 'Thêm vào danh sách';
  static const String share = 'Chia sẻ';
  static const String download = 'Tải xuống';
  static const String name = 'Tên:';
  static const String duration = 'Thời lượng:';
  static const String resolution = 'Độ phân giải:';
  static const String path = 'Đường dẫn:';
  static const String portraitVideo = 'Video dạng đứng';
  static const String landscapeVideo = 'Video dạng ngang';
  static const String portraitMode = 'Chế độ đứng';
  static const String landscapeMode = 'Chế độ ngang';
  static const String cannotPlayVideoTryingOtherMethod =
      'Không thể phát video. Đang thử phương pháp khác...';
  static const String noData = 'Không có dữ liệu';
  static const String readMore = 'Xem thêm';
  static const String sampleVideoPrefix = 'Sample Video';
  static const String sampleVideoTitle2 = 'Sample Video';
  static const String addedDebugVideosCount = 'Added debug videos';
  static const String videoCount = 'videos';
  static const String permissionRequestMessage =
      'Playdo cần quyền "Quản lý tất cả tệp" để phát video từ '
      'thiết bị của bạn. '
      'Vui lòng bật quyền này trong cài đặt.';
  static const String permissionInstructionMessage =
      'Sau khi cấp quyền, hãy quay lại ứng dụng và nhấn "Kiểm tra quyền"';
  static const String pleaseGrantManageAllFilesPermission =
      'Vui lòng cấp quyền "Quản lý tất cả tệp" cho ứng dụng';
  static const String checkPermission = 'Kiểm tra quyền';
  static const String grantPermission = 'Cấp quyền';
  static const String openSettings = 'Mở cài đặt';

  // File Extensions and Formats
  static const String mp4Extension = '.mp4';
  static const String mkvExtension = '.mkv';
  static const String aviExtension = '.avi';
  static const String movExtension = '.mov';
  static const String flvExtension = '.flv';
  static const String threegpExtension = '.3gp';
  static const String wmvExtension = '.wmv';
  static const String webmExtension = '.webm';
  static const String m4vExtension = '.m4v';
  static const String tsExtension = '.ts';
  static const String mtsExtension = '.mts';
  static const String m2tsExtension = '.m2ts';

  // Date and Time Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormatHours = 'h';
  static const String timeFormatMinutes = 'm';
  static const String timeFormatSeconds = 's';
  static const String timeFormatSeparator = ':';

  // File Size Units
  static const String bytesUnit = 'B';
  static const String kilobytesUnit = 'KB';
  static const String megabytesUnit = 'MB';
  static const String gigabytesUnit = 'GB';

  // Orientation Labels
  static const String portrait = 'portrait';
  static const String landscape = 'landscape';

  // Cache Messages
  static const String lruEvictionRemoved = 'LRU Eviction: Removed';
  static const String memoryCacheHit = 'Memory Cache Hit';
  static const String diskCacheHit = 'Disk Cache Hit';
  static const String cacheAdded = 'Cache Added';
  static const String diskCacheEvictionRemoved = 'Disk Cache Eviction: Removed';
  static const String diskCacheCleared = 'Disk cache cleared';
  static const String videoThumbnailCacheManagerMemoryCacheCleared =
      'VideoThumbnailCacheManager: Memory cache cleared';
  static const String videoThumbnailCacheManagerDisposed =
      'VideoThumbnailCacheManager: Disposed';
  static const String videoThumbnailCacheManagerCacheCleared =
      'VideoThumbnailCacheManager: Cache cleared';
  static const String thumbnailGenerationError = 'Thumbnail generation error';
  static const String unexpectedErrorGeneratingThumbnail =
      'Unexpected error generating thumbnail';
  static const String files = 'files';

  // Debug Messages - Cache
  static const String debugCacheLRUEviction = 'LRU Eviction: Removed';
  static const String debugCacheErrorCreatingDirectory =
      'Error creating cache directory';
  static const String debugCacheErrorCreatingDirectorySecondAttempt =
      'Error creating cache directory (second attempt)';
  static const String debugCacheErrorSavingThumbnail =
      'Error saving thumbnail to disk';
  static const String debugCacheErrorLoadingThumbnail =
      'Error loading thumbnail from disk';
  static const String debugCacheThumbnailGenerationError =
      'Thumbnail generation error';
  static const String debugCacheUnexpectedErrorGeneratingThumbnail =
      'Unexpected error generating thumbnail';
  static const String debugCacheMemoryCacheHit = 'Memory Cache Hit';
  static const String debugCacheDiskCacheHit = 'Disk Cache Hit';
  static const String debugCacheCacheAdded = 'Cache Added';
  static const String debugCacheErrorGeneratingThumbnail =
      'Error generating thumbnail';
  static const String debugCacheMemoryCacheEviction =
      'Memory Cache Eviction: Removed';
  static const String debugCacheDiskCacheEviction =
      'Disk Cache Eviction: Removed';
  static const String debugCacheErrorCleaningUpDiskCache =
      'Error cleaning up disk cache';
  static const String debugCacheDiskCacheCleared = 'Disk cache cleared';
  static const String debugCacheErrorClearingDiskCache =
      'Error clearing disk cache';
  static const String debugCacheMemoryCacheCleared =
      'VideoThumbnailCacheManager: Memory cache cleared';
  static const String debugCacheDisposed =
      'VideoThumbnailCacheManager: Disposed';
  static const String debugCacheCacheCleared =
      'VideoThumbnailCacheManager: Cache cleared';

  // ExoPlayer Messages
  static const String exoPlayerError = 'ExoPlayer error';
  static const String debugErrorExtractingVideoResolution =
      'Error extracting video resolution';

  // Debug Messages - Device Videos Service
  static const String debugCheckingPermissions =
      'Checking permissions using permission_handler';
  static const String debugManageExternalStoragePermission =
      'MANAGE_EXTERNAL_STORAGE permission';
  static const String debugManageExternalStoragePermissionGranted =
      'MANAGE_EXTERNAL_STORAGE permission granted';
  static const String debugStoragePermissionStatus =
      'Storage permission status';
  static const String debugPhotosPermissionStatus = 'Photos permission status';
  static const String debugVideosPermissionStatus = 'Videos permission status';
  static const String debugDownloadDirectoryExists =
      'Download directory exists';
  static const String debugCanList = 'can list';
  static const String debugCanAccessDownloadDirectory =
      'Can access Download directory, permission granted';
  static const String debugErrorAccessingDownloadDirectory =
      'Error accessing Download directory';
  static const String debugPhotosAndVideosPermissionsGranted =
      'Photos and Videos permissions granted';
  static const String debugPermissionPermanentlyDenied =
      'Permission permanently denied';
  static const String debugPermissionDenied = 'Permission denied';
  static const String debugPermissionDeniedByDefault =
      'Permission denied by default';

  static const String debugSuccessfullyListedDirectory =
      'Successfully listed directory, found';
  static const String debugCannotListDirectory = 'Cannot list directory';
  static const String debugRequestingPermissions =
      'Requesting permissions using permission_handler';
  static const String debugAndroid11RequestingManageExternalStorage =
      'Android 11+, requesting MANAGE_EXTERNAL_STORAGE';
  static const String debugOpenedManageAllFilesSettings =
      'Opened manage all files settings';
  static const String debugStoragePermissionRequestResult =
      'Storage permission request result';
  static const String debugPhotosPermissionRequestResult =
      'Photos permission request result';
  static const String debugVideosPermissionRequestResult =
      'Videos permission request result';
  static const String debugErrorRequestingPermission =
      'Error requesting permission';
  static const String debugAndroidSDKVersion = 'Android SDK version';
  static const String debugStartingGetVideos = 'Starting getVideos()';

  static const String debugPermissionNotGrantedReturningEmptyList =
      'Permission not granted, returning empty list';
  static const String debugScanningDeviceForVideos =
      'Scanning device for videos';
  static const String debugScanningFolder = 'Scanning folder';
  static const String debugFoundFilesInFolder = 'Found';
  static const String debugFoundVideo = 'Found video';
  static const String debugErrorScanningDirectory = 'Error scanning directory';
  static const String debugDirectoryDoesNotExist = 'Directory does not exist';
  static const String debugFoundVideosOnDevice = 'Found';
  static const String debugErrorScanningForVideos = 'Error scanning for videos';
  static const String debugReturningEmptyListFromGetVideos =
      'Returning empty list from getVideos()';
  static const String debugCreatingSampleVideosForDebugging =
      'Creating sample videos for debugging';
  static const String debugCreatedSampleVideo = 'Created sample video';

  // Debug Messages - Video Thumbnail
  static const String debugErrorDuringPlayPause = 'Error during play/pause';
  static const String debugErrorEstimatingDurationFromFileSize =
      'Error estimating duration from file size';
  static const String debugErrorInitializingVideoController =
      'Error initializing video controller';

  // Debug Messages - Video Player Example
  static const String debugInitializingExamplePlayer =
      'Initializing example player with URL';
  static const String debugUsingNetworkController =
      'Using network controller for URL';
  static const String debugUsingFileController =
      'Using file controller for path';
  static const String debugFileExistsAtPath = 'File exists at path';
  static const String debugFileDoesNotExistAtPath =
      'File does not exist at path';
  static const String debugErrorCreatingFileController =
      'Error creating file controller';

  // Main App Debug Messages
  static const String debugIntentHandlingInitialized =
      'Intent handling initialized';
  static const String debugReceivedIntentData = 'Received intent data';
  static const String debugErrorInitializingIntentHandling =
      'Error initializing intent handling';
  static const String debugAppDocumentsDirectory = 'App documents directory';

  // Navigation Debug Messages
  static const String debugRoutingToEnhancedVideoPlayer =
      'Routing to enhanced video player with URL';
  static const String debugTitle = 'title';
  static const String debugFromIntent = 'fromIntent';
  static const String debugDetectedDirectURIFromIntent =
      'Detected direct URI from intent';
  static const String debugRedirectingToHome = 'redirecting to home';
  static const String debugOpeningEnhancedVideoPlayer =
      'Opening enhanced video player with URL';
  static const String debugErrorExtractingTitleFromURL =
      'Error extracting title from URL';

  // Intent Handler Debug Messages
  static const String debugProcessingVideoPath = 'Processing video path';
  static const String debugSplitPathFromSeparator =
      'Split path from | separator, using';
  static const String debugUsingContentURIAsIs = 'Using content:// URI as is';
  static const String debugFileExistsAt = 'File exists at';
  static const String debugFileDoesNotExistAt = 'File does not exist at';
  static const String debugRemovedFilePrefixOnIOS =
      'Removed file:// prefix on iOS';
  static const String debugFileExistsAtAbsolutePath =
      'File exists at absolute path';
  static const String debugTryingWithFilePrefix = 'Trying with file:// prefix';

  // Device Videos Grid Debug Messages
  static const String debugPickVideosGot = 'DEBUG: _pickVideos got';
  static const String debugVideos = 'videos';
  static const String debugErrorInPickVideos = 'DEBUG: Error in _pickVideos';
  static const String debugAlreadyLoadingReturning =
      'DEBUG: Already loading, returning';

  // debugDeviceVideosServiceGetVideosReturned already defined above
  static const String debugWidgetIsStillMountedUpdatingState =
      'DEBUG: Widget is still mounted, updating state';
  static const String debugVideo = 'DEBUG: Video';
  // debugWidgetIsNoLongerMounted already defined above
  static const String debugErrorInLoadVideos = 'DEBUG: Error in _loadVideos';
  static const String debugWidgetIsStillMountedUpdatingStateAfterError =
      'DEBUG: Widget is still mounted, updating state after error';
  // debugWidgetIsNoLongerMountedAfterError already defined above
  static const String debugGot = 'DEBUG: Got';
  static const String debugDebugVideos = 'debug videos';
  static const String debugTotalDebugVideos = 'DEBUG: Total debug videos';
  static const String debugErrorInAddDebugVideos =
      'DEBUG: Error in _addDebugVideos';
  // debugStartingRefreshVideos already defined above

  // Video Player Factory Debug Messages
  static const String debugErrorCreatingVideoController =
      'Error creating video controller';
  static const String debugErrorInitializingVideo = 'Error initializing video';
  static const String debugRetryingInitialization = 'Retrying initialization';
  static const String debugErrorGettingPathFromController =
      'Error getting path from controller';
  static const String debugErrorCreatingChewieController =
      'Error creating ChewieController';
  static const String debugErrorPlayingWithSystemIntent =
      'Error playing with system intent';

  // Video Detail Page Debug Messages
  static const String debugErrorLoadingVideoInfo =
      'DEBUG: Error loading video info';
  static const String debugVideoError = 'DEBUG: Video error';
  // Better Player Page Debug Messages
  static const String debugProcessingVideoURL = 'Processing video URL';
  static const String debugTryingWithOriginalURL = 'Trying with original URL';
  // debugErrorInitializingVideoPlayer already defined above
  // debugStackTrace already defined above
  static const String debugVideoDimensions = 'Video dimensions';
  static const String debugBetterPlayerException = 'BetterPlayer exception';

  // Video Player Debug Messages
  static const String debugErrorExtractingVideoTitle =
      'Error extracting video title';

  // Optimized Video Thumbnail Debug Messages
  static const String debugErrorLoadingThumbnail = 'Error loading thumbnail';

  // Universal Video Player Debug Messages
  static const String debugErrorCreatingController =
      'Error creating controller';
  static const String debugErrorInitializingController =
      'Error initializing controller';
  static const String debugVideoAspectRatio = 'Video aspect ratio';
  static const String debugVideoOrientation = 'Video orientation';
  static const String debugErrorInitializingPlayer =
      'Error initializing player';
  static const String debugSwitchingToStrategy = 'Switching to strategy';

  // Simple Cached Video Thumbnail Debug Messages
  // debugErrorInitializingVideoController already defined above

  // Cached Video Thumbnail Debug Messages
  static const String debugInitializingVideoController =
      'Initializing video controller for path';
  static const String debugCheckingFileExists = 'Checking if file exists';
  static const String debugFileNotExist =
      'File does not exist, showing error state';
  static const String debugControllerInitializedSuccessfully =
      'Controller initialized successfully';

  // Home Page Debug Messages
  static const String debugErrorCheckingForVideoIntent =
      'Error checking for video intent';
  static const String debugHandlingVideoIntentWithURL =
      'Handling video intent with URL';
  static const String debugStartingCheckPermission =
      'Starting _checkPermission()';
  static const String debugPermissionCheckTimedOut =
      'Permission check timed out after 5 seconds';
  static const String debugPermissionStatus = 'Permission status';
  static const String debugErrorCheckingPermission =
      'Error checking permission';
  // debugStackTrace already defined above

  // Route Names
  static const String enhancedVideoRoute = '/enhanced-video';
  static const String videoDetailRoute = '/video-detail';
  static const String homeRoute = '/';

  // Intent and Navigation
  static const String videoUrlParam = 'videoUrl';
  static const String videoTitleParam = 'videoTitle';
  static const String isLocalFileParam = 'isLocalFile';
  static const String fromIntentParam = 'fromIntent';

  // Rough estimates and comments
  static const String roughEstimateComment =
      '// Rough estimate: 1MB = 10 seconds of video (very approximate)';
  static const String mediumQualityComment =
      '// Medium quality for better performance';
  static const String reasonableSizeComment =
      '// Reasonable size for thumbnails';
  static const String searchBarComment = '// Search bar (60% width)';
  static const String fixedHeightComment =
      '// Giới hạn chiều cao cố định cho cả card';
}
