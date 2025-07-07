import 'package:flutter/material.dart';

class AppLocalizations {
  static const delegate = AppLocalizationsDelegate();
  static const supportedLocales = [Locale('en'), Locale('vi')];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  final Locale locale;
  AppLocalizations(this.locale);

  String get appTitle =>
      locale.languageCode == 'vi' ? 'Trình diễn Theme' : 'Theme Showcase';
  String get themeMode =>
      locale.languageCode == 'vi' ? 'Chế độ Theme' : 'Theme Mode';
  String get lightTheme => locale.languageCode == 'vi' ? 'Sáng' : 'Light';
  String get darkTheme => locale.languageCode == 'vi' ? 'Tối' : 'Dark';
  String get systemTheme => locale.languageCode == 'vi' ? 'Hệ thống' : 'System';
  String get fontSize => locale.languageCode == 'vi' ? 'Cỡ chữ' : 'Font Size';
  String get fontFamily =>
      locale.languageCode == 'vi' ? 'Phông chữ' : 'Font Family';
  String get language => locale.languageCode == 'vi' ? 'Ngôn ngữ' : 'Language';
  String get english => 'English';
  String get vietnamese => 'Tiếng Việt';
  String get sampleText => locale.languageCode == 'vi'
      ? 'Đây là văn bản mẫu để xem trước theme và font.'
      : 'This is sample text to preview theme and font.';
  String get sampleButton =>
      locale.languageCode == 'vi' ? 'Nút mẫu' : 'Sample Button';
  String get textComponents =>
      locale.languageCode == 'vi' ? 'Văn bản' : 'Text';
  String get buttonComponents =>
      locale.languageCode == 'vi' ? 'Nút bấm' : 'Button';
  String get inputComponents =>
      locale.languageCode == 'vi' ? 'Nhập liệu' : 'Input';
  String get layoutComponents =>
      locale.languageCode == 'vi' ? 'Bố cục' : 'Layout';
  String get listComponents =>
      locale.languageCode == 'vi' ? 'Danh sách' : 'List';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
