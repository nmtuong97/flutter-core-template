import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Localization
class AppLocalizations {
  static const delegate = AppLocalizationsDelegate();
  static const supportedLocales = [Locale('en'), Locale('vi')];
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  final Locale locale;
  AppLocalizations(this.locale);
  
  String get appTitle => locale.languageCode == 'vi' ? 'Trình diễn Theme' : 'Theme Showcase';
  String get themeMode => locale.languageCode == 'vi' ? 'Chế độ Theme' : 'Theme Mode';
  String get lightTheme => locale.languageCode == 'vi' ? 'Sáng' : 'Light';
  String get darkTheme => locale.languageCode == 'vi' ? 'Tối' : 'Dark';
  String get systemTheme => locale.languageCode == 'vi' ? 'Hệ thống' : 'System';
  String get fontSize => locale.languageCode == 'vi' ? 'Cỡ chữ' : 'Font Size';
  String get fontFamily => locale.languageCode == 'vi' ? 'Phông chữ' : 'Font Family';
  String get language => locale.languageCode == 'vi' ? 'Ngôn ngữ' : 'Language';
  String get english => 'English';
  String get vietnamese => 'Tiếng Việt';
  String get sampleText => locale.languageCode == 'vi' 
    ? 'Đây là văn bản mẫu để xem trước theme và font.'
    : 'This is sample text to preview theme and font.';
  String get sampleButton => locale.languageCode == 'vi' ? 'Nút mẫu' : 'Sample Button';
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

// Theme Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  double _fontSize = 16.0;
  String _fontFamily = 'Roboto';
  
  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;
  
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.getTextTheme(_fontFamily, ThemeData.light().textTheme).copyWith(
      bodyLarge: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize),
      bodyMedium: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize - 2),
      bodySmall: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize - 4),
    ),
  );
  
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.getTextTheme(_fontFamily, ThemeData.dark().textTheme).copyWith(
      bodyLarge: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize),
      bodyMedium: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize - 2),
      bodySmall: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize - 4),
    ),
  );
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _savePreferences();
  }
  
  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
    _savePreferences();
  }
  
  void setFontFamily(String family) {
    _fontFamily = family;
    notifyListeners();
    _savePreferences();
  }
  
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeMode.toString());
    await prefs.setDouble('fontSize', _fontSize);
    await prefs.setString('fontFamily', _fontFamily);
  }
  
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'ThemeMode.system';
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    _fontFamily = prefs.getString('fontFamily') ?? 'Roboto';
    
    switch (themeModeString) {
      case 'ThemeMode.light':
        _themeMode = ThemeMode.light;
        break;
      case 'ThemeMode.dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}

// Language Provider
class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  
  Locale get locale => _locale;
  
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
    _saveLocale();
  }
  
  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', _locale.languageCode);
  }
  
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('locale') ?? 'en';
    _locale = Locale(localeCode);
    notifyListeners();
  }
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'Flutter Theme Showcase',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: languageProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ThemeShowcasePage(),
          );
        },
      ),
    );
  }
}

// Theme Showcase Page
class ThemeShowcasePage extends StatelessWidget {
  const ThemeShowcasePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Mode Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.themeMode,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<ThemeMode>(
                            title: Text(l10n.lightTheme),
                            value: ThemeMode.light,
                            groupValue: themeProvider.themeMode,
                            onChanged: (value) => themeProvider.setThemeMode(value!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<ThemeMode>(
                            title: Text(l10n.darkTheme),
                            value: ThemeMode.dark,
                            groupValue: themeProvider.themeMode,
                            onChanged: (value) => themeProvider.setThemeMode(value!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<ThemeMode>(
                            title: Text(l10n.systemTheme),
                            value: ThemeMode.system,
                            groupValue: themeProvider.themeMode,
                            onChanged: (value) => themeProvider.setThemeMode(value!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Font Size Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.fontSize,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: themeProvider.fontSize,
                      min: 12.0,
                      max: 24.0,
                      divisions: 12,
                      label: '${themeProvider.fontSize.round()}',
                      onChanged: (value) => themeProvider.setFontSize(value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Font Family Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.fontFamily,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: themeProvider.fontFamily,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
                        DropdownMenuItem(value: 'Poppins', child: Text('Poppins')),
                        DropdownMenuItem(value: 'Merriweather', child: Text('Merriweather')),
                      ],
                      onChanged: (value) => themeProvider.setFontFamily(value!),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Language Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.language,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.english),
                            value: 'en',
                            groupValue: languageProvider.locale.languageCode,
                            onChanged: (value) => languageProvider.setLocale(Locale(value!)),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.vietnamese),
                            value: 'vi',
                            groupValue: languageProvider.locale.languageCode,
                            onChanged: (value) => languageProvider.setLocale(Locale(value!)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Preview Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preview',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.sampleText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(l10n.sampleButton),
                    ),
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(value: 0.7),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Sample ListTile'),
                      subtitle: const Text('This is a subtitle'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize providers
  final themeProvider = ThemeProvider();
  final languageProvider = LanguageProvider();
  
  await themeProvider.loadPreferences();
  await languageProvider.loadLocale();
  
  runApp(const MyApp());
}