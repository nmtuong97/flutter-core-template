## Tài liệu Thiết kế: Phong cách Liquid Glass UI

Tài liệu này định nghĩa các nguyên tắc, thuộc tính và quy tắc cốt lõi để triển khai phong cách "Liquid Glass UI" một cách nhất quán trên toàn bộ dự án.

### 1\. Nguyên tắc Cốt lõi

Liquid Glass UI là một phong cách glassmorphism hiện đại, tập trung vào việc mô phỏng các lớp vật liệu kính mờ, khuếch tán ánh sáng động.

  * **Đa lớp & Chiều sâu (Transparency Layering & Depth):** Giao diện được xây dựng từ nhiều lớp bán trong suốt. Độ mờ (blur) và độ trong suốt (alpha) được sử dụng để tạo ra hệ thống phân cấp Z-index rõ ràng (elevation mapping).
  * **Khuếch tán Ánh sáng (Dynamic Light Diffusion):** Các bề mặt mô phỏng cách ánh sáng đi qua và phản chiếu trên kính. Điều này được thể hiện qua các `specular highlight` (vùng sáng phản xạ) và các `gradient mask` tinh tế.
  * **Mô phỏng Vật liệu (Material Simulation):** Chúng ta mô phỏng hiệu ứng khúc xạ (refraction) thông qua `BackdropFilter` (blur) và phản chiếu (reflection) qua các lớp `gradient` và `shadow` siêu mịn.
  * **Phản hồi Tinh tế (Micro-motion Feedback):** Tương tác (hover, tap) được phản hồi bằng các chuyển động nhỏ (parallax, scale \< 5%), tạo cảm giác vật thể đang "nổi" và phản ứng với con trỏ.
  * **Thích ứng Bối cảnh (Contextual Adaptivity):** Màu sắc (tint), độ mờ (blur sigma), và độ trong suốt (alpha) phải tự động điều chỉnh theo bối cảnh nền (background) và chế độ Sáng/Tối (Light/Dark mode) để đảm bảo độ dễ đọc.

### 2\. Đặc tả Thị giác (Visual Specification)

Để đảm bảo tính nhất quán, tất cả các component "Liquid Glass" phải tuân thủ các thông số kỹ thuật sau:

| Thuộc tính | Tham số khuyến nghị | Ghi chú kỹ thuật |
| :--- | :--- | :--- |
| **Blur Sigma** | 16 – 30 | Tối ưu cho `ImageFilter.blur`. Quá thấp sẽ mất hiệu ứng, quá cao sẽ nặng và mất chi tiết. |
| **Tint Overlay** | `rgba(white, 0.15)` (Light) <br> `rgba(black, 0.25)` (Dark) | Dùng để tạo màu cho kính. Luôn phải đảm bảo contrast \> 4.5:1 cho nội dung. |
| **Corner Radius** | 12 – 24 px | Sử dụng `ClipRRect` hoặc `BorderRadius.circular`. |
| **Border** | `Color(0x33FFFFFF)` (1px) | (Gợi ý thêm) Một đường viền 1px siêu mỏng, trong suốt (ví dụ `Colors.white.withOpacity(0.2)`) giúp xác định rõ cạnh của tấm kính. |
| **Specular Light** | Linear Gradient | Thường đặt ở góc (ví dụ: Top-Left) để giả lập ánh sáng phản chiếu. |
| **Shadow** | Blur: 8–12, Opacity: 0.05–0.1 | Shadow cực nhẹ, chỉ để tạo cảm giác "nổi" (elevation) khỏi nền. |

### 3\. Nguyên tắc Tương tác & UX

  * **Chuyển động (Motion) phải tối giản:** Mọi animation phải dưới 300ms (ví dụ `Curves.easeOutCubic`). Tránh các chuyển động lớn, giật cục làm phá vỡ cảm giác "kính".
  * **Ưu tiên Đọc (Readability):** Luôn kiểm tra độ tương phản trên các nền phức tạp hoặc nền động. Văn bản phải luôn rõ ràng.
  * **Tối ưu Hiệu suất (Performance-First):** `BackdropFilter` là một tác vụ nặng cho GPU. Phải cân nhắc tắt hiệu ứng blur trên các thiết bị yếu hoặc khi FPS \< 50.

### 4\. Component Triển khai Cơ sở (Base Implementation)

Sử dụng component này làm nền tảng cho tất cả các widget Liquid Glass.

```dart
import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlass extends StatelessWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.blur = 24.0,
    this.tint = const Color(0x26FFFFFF),
    this.borderRadius = 20.0,
    this.borderColor = const Color(0x33FFFFFF), // Colors.white.withOpacity(0.2)
  });

  final Widget child;
  final double blur;
  final Color tint;
  final double borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: tint,
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
```

> **Ghi chú:** Kết hợp `LiquidGlass` với `AnimatedContainer` (cho các thay đổi trạng thái) hoặc `MouseRegion` / `InkWell` (cho các hiệu ứng hover/tap) để tạo ra các phản hồi tương tác động.

### 5\. Quy tắc Áp dụng (Use Case Guidelines)

#### 📍 Khi nên sử dụng

  * **System Overlays (Thanh trạng thái, Dock):** Blur nhẹ, tint thích ứng để giữ readability.
  * **Floating Controls (Điều khiển nhạc, Chat head):** Tách biệt khỏi nền, shadow nhẹ.
  * **Dialogs / Modal Sheets:** Blur nền mạnh để tập trung vào nội dung modal.
  * **Navigation (App bar, Bottom sheet):** Blur bán trong suốt để tạo chiều sâu.
  * **Cards / Tiles (Hover):** Thêm hiệu ứng ánh sáng động khi hover/tap.

#### ⛔ Khi KHÔNG nên sử dụng

  * **Nền quá chi tiết hoặc động (Video, Animation):** Gây mất tập trung và giảm tương phản nghiêm trọng.
  * **Thiết bị yếu (Low-end GPU):** Gây giảm FPS. Cần có logic để tắt (fallback) về một `Container` mờ thông thường.
  * **Khu vực cần tập trung đọc (Dense text, Forms):** Vùng nhập liệu hoặc văn bản dày đặc cần nền đặc (solid) để tối đa hóa readability.
