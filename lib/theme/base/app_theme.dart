import 'package:flutter/material.dart';

/// Abstract class định nghĩa cấu trúc cơ bản cho tất cả các theme
abstract class AppTheme {
  /// ID duy nhất của theme, dùng để lưu trữ và nhận dạng
  String get id;

  /// Tên hiển thị của theme
  String get name;

  /// Mô tả ngắn về theme
  String get description;

  /// Dữ liệu theme sáng
  ThemeData get lightThemeData;

  /// Dữ liệu theme tối
  ThemeData get darkThemeData;

  /// Kiểm tra xem theme này có phải là theme mặc định không
  bool get isDefault => false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
