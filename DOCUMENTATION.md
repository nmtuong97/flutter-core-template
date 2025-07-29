# Tài liệu dự án Flutter Core Template

Đây là tài liệu toàn diện cho dự án Flutter Core Template, cung cấp hướng dẫn chi tiết về cách thiết lập, phát triển và triển khai ứng dụng.

## 1. Tổng quan dự án

-   **Mục đích**: Nền tảng khởi đầu cho các ứng dụng Flutter, tập trung vào cấu trúc module, khả năng mở rộng và các tính năng cốt lõi như quản lý chủ đề và đa ngôn ngữ.
-   **Công nghệ sử dụng**: Flutter, Dart.

## 2. Bắt đầu nhanh

### 2.1. Yêu cầu hệ thống

-   Flutter SDK (phiên bản khuyến nghị: 3.x.x)
-   Dart SDK (đi kèm với Flutter SDK)
-   Trình chỉnh sửa mã (VS Code, Android Studio)

### 2.2. Cài đặt

1.  Clone repository:

    ```bash
    git clone https://github.com/nmtuong97/flutter-core-template.git
    cd flutter-core-template
    ```

2.  Tải các dependency:

    ```bash
    flutter pub get
    ```

### 2.3. Chạy ứng dụng

Để chạy ứng dụng trên thiết bị hoặc trình giả lập:

```bash
flutter run
```

## 3. Cấu trúc dự án

Dự án được tổ chức theo cấu trúc module, giúp dễ dàng quản lý và mở rộng:

```
lib/
├── app/                  # Cấu hình ứng dụng chính
├── bootstrap.dart        # Khởi tạo ứng dụng
├── constants/            # Các hằng số và chuỗi cố định
├── l10n/                 # Đa ngôn ngữ (Localization)
├── pages/                # Các trang (màn hình) của ứng dụng
├── providers/            # Quản lý trạng thái và dữ liệu
├── theme/                # Quản lý chủ đề (Theming)
└── widgets/              # Các widget dùng chung
```

## 4. Kiểm thử

Để chạy tất cả các bài kiểm thử đơn vị và widget:

```bash
flutter test --coverage --test-randomize-ordering-seed random
```

Để xem báo cáo độ bao phủ mã (coverage report):

```bash
# Tạo báo cáo
genhtml coverage/lcov.info -o coverage/

# Mở báo cáo
open coverage/index.html
```

## 5. Đa ngôn ngữ (Localization)

Dự án sử dụng `flutter_localizations` và tuân theo hướng dẫn đa ngôn ngữ chính thức của Flutter.

### 5.1. Thêm chuỗi dịch

1.  Mở tệp `app_en.arb` tại `lib/l10n/arb/app_en.arb`.
2.  Thêm cặp khóa/giá trị và mô tả mới:

    ```arb
    {
        "@@locale": "en",
        "helloWorld": "Hello World",
        "@helloWorld": {
            "description": "Hello World Text"
        }
    }
    ```

3.  Sử dụng chuỗi mới trong mã:

    ```dart
    import 'package:flutter_core_template/l10n/l10n.dart';

    @override
    Widget build(BuildContext context) {
      final l10n = context.l10n;
      return Text(l10n.helloWorld);
    }
    ```

### 5.2. Thêm ngôn ngữ được hỗ trợ

Cập nhật mảng `CFBundleLocalizations` trong tệp `Info.plist` tại `ios/Runner/Info.plist` để bao gồm ngôn ngữ mới:

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### 5.3. Thêm bản dịch

1.  Đối với mỗi ngôn ngữ được hỗ trợ, thêm một tệp ARB mới trong `lib/l10n/arb` (ví dụ: `app_es.arb`).
2.  Thêm các chuỗi đã dịch vào mỗi tệp `.arb`.

### 5.4. Tạo bản dịch

Để sử dụng các thay đổi bản dịch mới nhất, bạn cần tạo chúng:

```bash
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Hoặc chạy `flutter run`, quá trình tạo mã sẽ diễn ra tự động.

## 6. Chủ đề (Theming)

Dự án hỗ trợ nhiều chủ đề khác nhau. Bạn có thể tùy chỉnh hoặc thêm chủ đề mới trong thư mục `lib/theme/`.

### 6.1. Cấu trúc chủ đề

-   `app_themes.dart`: Định nghĩa các chủ đề có sẵn.
-   `theme_provider.dart`: Quản lý việc chuyển đổi chủ đề.
-   `themes/`: Chứa các định nghĩa chủ đề cụ thể (ví dụ: `cyberpunk_theme.dart`).

### 6.2. Thêm chủ đề mới

1.  Tạo một tệp Dart mới trong `lib/theme/themes/` (ví dụ: `my_custom_theme.dart`).
2.  Định nghĩa `ThemeData` cho chủ đề của bạn.
3.  Thêm chủ đề vào `AppTheme` enum trong `app_themes.dart`.
4.  Cập nhật `ThemeProvider` để hỗ trợ chủ đề mới.

## 7. Các thành phần UI (UI Components)

Dự án cung cấp một số widget dùng chung trong thư mục `lib/widgets/`:

-   `language_selector.dart`: Widget chọn ngôn ngữ.
-   `theme_selector.dart`: Widget chọn chủ đề.
-   `theme_settings_bottom_sheet.dart`: Bottom sheet cài đặt chủ đề.

Bạn có thể tái sử dụng hoặc mở rộng các thành phần này.

## 8. Triển khai (Deployment)

Để triển khai ứng dụng của bạn lên các nền tảng khác nhau, hãy tham khảo tài liệu chính thức của Flutter:

-   [Triển khai ứng dụng Android](https://docs.flutter.dev/deployment/android)
-   [Triển khai ứng dụng iOS](https://docs.flutter.dev/deployment/ios)
-   [Triển khai ứng dụng Web](https://docs.flutter.dev/deployment/web)
-   [Triển khai ứng dụng Windows](https://docs.flutter.dev/deployment/windows)

---

**Lưu ý**: Tài liệu này sẽ được cập nhật thường xuyên. Vui lòng kiểm tra các phiên bản mới nhất.