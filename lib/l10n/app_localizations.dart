import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme Showcase'**
  String get appTitle;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font Family'**
  String get fontFamily;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @sampleText.
  ///
  /// In en, this message translates to:
  /// **'This is sample text to preview theme and font.'**
  String get sampleText;

  /// No description provided for @sampleButton.
  ///
  /// In en, this message translates to:
  /// **'Sample Button'**
  String get sampleButton;

  /// No description provided for @textComponents.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textComponents;

  /// No description provided for @buttonComponents.
  ///
  /// In en, this message translates to:
  /// **'Button'**
  String get buttonComponents;

  /// No description provided for @inputComponents.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get inputComponents;

  /// No description provided for @layoutComponents.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layoutComponents;

  /// No description provided for @listComponents.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listComponents;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @sampleListTile.
  ///
  /// In en, this message translates to:
  /// **'Sample ListTile'**
  String get sampleListTile;

  /// No description provided for @sampleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This is a subtitle'**
  String get sampleSubtitle;

  /// No description provided for @rowExample.
  ///
  /// In en, this message translates to:
  /// **'Row Example:'**
  String get rowExample;

  /// No description provided for @columnExample.
  ///
  /// In en, this message translates to:
  /// **'Column Example:'**
  String get columnExample;

  /// No description provided for @stackExample.
  ///
  /// In en, this message translates to:
  /// **'Stack Example:'**
  String get stackExample;

  /// No description provided for @expandedFlexibleExample.
  ///
  /// In en, this message translates to:
  /// **'Expanded/Flexible Example:'**
  String get expandedFlexibleExample;

  /// No description provided for @paddingExample.
  ///
  /// In en, this message translates to:
  /// **'Padding Example:'**
  String get paddingExample;

  /// No description provided for @alignExample.
  ///
  /// In en, this message translates to:
  /// **'Align Example:'**
  String get alignExample;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @layer.
  ///
  /// In en, this message translates to:
  /// **'Layer'**
  String get layer;

  /// No description provided for @expanded.
  ///
  /// In en, this message translates to:
  /// **'Expanded'**
  String get expanded;

  /// No description provided for @flexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get flexible;

  /// No description provided for @paddedContent.
  ///
  /// In en, this message translates to:
  /// **'Padded Content'**
  String get paddedContent;

  /// No description provided for @bottomRight.
  ///
  /// In en, this message translates to:
  /// **'Bottom Right'**
  String get bottomRight;

  /// No description provided for @listViewExample.
  ///
  /// In en, this message translates to:
  /// **'ListView Example:'**
  String get listViewExample;

  /// No description provided for @gridViewExample.
  ///
  /// In en, this message translates to:
  /// **'GridView Example:'**
  String get gridViewExample;

  /// No description provided for @descriptionOfItem.
  ///
  /// In en, this message translates to:
  /// **'Description of item'**
  String get descriptionOfItem;

  /// No description provided for @gridItem.
  ///
  /// In en, this message translates to:
  /// **'Grid Item'**
  String get gridItem;

  /// No description provided for @textField.
  ///
  /// In en, this message translates to:
  /// **'Text Field'**
  String get textField;

  /// No description provided for @textFormField.
  ///
  /// In en, this message translates to:
  /// **'Text Form Field'**
  String get textFormField;

  /// No description provided for @checkbox.
  ///
  /// In en, this message translates to:
  /// **'Checkbox'**
  String get checkbox;

  /// No description provided for @radioButton1.
  ///
  /// In en, this message translates to:
  /// **'Radio Button 1'**
  String get radioButton1;

  /// No description provided for @radioButton2.
  ///
  /// In en, this message translates to:
  /// **'Radio Button 2'**
  String get radioButton2;

  /// No description provided for @switchWidget.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get switchWidget;

  /// No description provided for @option1.
  ///
  /// In en, this message translates to:
  /// **'Option 1'**
  String get option1;

  /// No description provided for @option2.
  ///
  /// In en, this message translates to:
  /// **'Option 2'**
  String get option2;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
