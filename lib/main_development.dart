import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_theme_showcase/app/app.dart';
import 'package:flutter_theme_showcase/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  bootstrap(() => const App());
}
