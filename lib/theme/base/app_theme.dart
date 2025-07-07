import 'package:flutter/material.dart';

/// Abstract class định nghĩa cấu trúc cơ bản cho tất cả các theme
abstract class AppTheme {
  /// ID duy nhất của theme, dùng để lưu trữ và nhận dạng
  String get id;
  
  /// Tên hiển thị của theme
  String get name;
  
  /// Mô tả ngắn về theme
  String get description;
  
  /// Tạo theme sáng
  ThemeData getLightTheme({
    required double fontSize,
    required String fontFamily,
  });
  
  /// Tạo theme tối
  ThemeData getDarkTheme({
    required double fontSize,
    required String fontFamily,
  });
  
  /// Kiểm tra xem theme này có phải là theme mặc định không
  bool get isDefault => false;
}
