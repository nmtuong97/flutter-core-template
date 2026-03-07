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
    Locale('vi'),
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

  /// No description provided for @themeSettings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// No description provided for @themeModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose between light, dark, or system theme'**
  String get themeModeDescription;

  /// No description provided for @lightThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Light theme for bright environments'**
  String get lightThemeDescription;

  /// No description provided for @darkThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Dark theme for low-light environments'**
  String get darkThemeDescription;

  /// No description provided for @systemThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow system theme setting'**
  String get systemThemeDescription;

  /// No description provided for @fontSettings.
  ///
  /// In en, this message translates to:
  /// **'Font Settings'**
  String get fontSettings;

  /// No description provided for @fontSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Customize font size and family'**
  String get fontSettingsDescription;

  /// No description provided for @appThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose from available app themes'**
  String get appThemeDescription;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get languageDescription;

  /// No description provided for @englishDescription.
  ///
  /// In en, this message translates to:
  /// **'English language interface'**
  String get englishDescription;

  /// No description provided for @vietnameseDescription.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese language interface'**
  String get vietnameseDescription;

  /// No description provided for @previewDescription.
  ///
  /// In en, this message translates to:
  /// **'Preview how your theme looks'**
  String get previewDescription;

  /// No description provided for @fontPreview.
  ///
  /// In en, this message translates to:
  /// **'Font Preview'**
  String get fontPreview;

  /// No description provided for @fontPreviewHeadline.
  ///
  /// In en, this message translates to:
  /// **'Headline Text Sample'**
  String get fontPreviewHeadline;

  /// No description provided for @fontPreviewBody.
  ///
  /// In en, this message translates to:
  /// **'This is body text that shows how your selected font family and size will appear in the app.'**
  String get fontPreviewBody;

  /// No description provided for @fontPreviewCaption.
  ///
  /// In en, this message translates to:
  /// **'Caption and small text preview'**
  String get fontPreviewCaption;

  /// No description provided for @robotoDescription.
  ///
  /// In en, this message translates to:
  /// **'Clean and modern sans-serif font'**
  String get robotoDescription;

  /// No description provided for @poppinsDescription.
  ///
  /// In en, this message translates to:
  /// **'Geometric sans-serif with rounded edges'**
  String get poppinsDescription;

  /// No description provided for @merriweatherDescription.
  ///
  /// In en, this message translates to:
  /// **'Elegant serif font for readability'**
  String get merriweatherDescription;

  /// No description provided for @interDescription.
  ///
  /// In en, this message translates to:
  /// **'Optimized for digital interfaces'**
  String get interDescription;

  /// No description provided for @components.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get components;

  /// No description provided for @typography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get typography;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primary;

  /// No description provided for @filled.
  ///
  /// In en, this message translates to:
  /// **'Filled'**
  String get filled;

  /// No description provided for @outlined.
  ///
  /// In en, this message translates to:
  /// **'Outlined'**
  String get outlined;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @inputFields.
  ///
  /// In en, this message translates to:
  /// **'Input Fields'**
  String get inputFields;

  /// No description provided for @sampleTextField.
  ///
  /// In en, this message translates to:
  /// **'Sample Text Field'**
  String get sampleTextField;

  /// No description provided for @cardsAndLists.
  ///
  /// In en, this message translates to:
  /// **'Cards & Lists'**
  String get cardsAndLists;

  /// No description provided for @progressIndicators.
  ///
  /// In en, this message translates to:
  /// **'Progress Indicators'**
  String get progressIndicators;

  /// No description provided for @loadingIndicator.
  ///
  /// In en, this message translates to:
  /// **'Loading indicator'**
  String get loadingIndicator;

  /// No description provided for @displayLarge.
  ///
  /// In en, this message translates to:
  /// **'Display Large'**
  String get displayLarge;

  /// No description provided for @headlineMedium.
  ///
  /// In en, this message translates to:
  /// **'Headline Medium'**
  String get headlineMedium;

  /// No description provided for @titleLarge.
  ///
  /// In en, this message translates to:
  /// **'Title Large'**
  String get titleLarge;

  /// No description provided for @bodyLarge.
  ///
  /// In en, this message translates to:
  /// **'Body Large'**
  String get bodyLarge;

  /// No description provided for @bodyMedium.
  ///
  /// In en, this message translates to:
  /// **'Body Medium'**
  String get bodyMedium;

  /// No description provided for @bodySmall.
  ///
  /// In en, this message translates to:
  /// **'Body Small'**
  String get bodySmall;

  /// No description provided for @labelMedium.
  ///
  /// In en, this message translates to:
  /// **'Label Medium'**
  String get labelMedium;

  /// No description provided for @primaryColors.
  ///
  /// In en, this message translates to:
  /// **'Primary Colors'**
  String get primaryColors;

  /// No description provided for @secondaryColors.
  ///
  /// In en, this message translates to:
  /// **'Secondary Colors'**
  String get secondaryColors;

  /// No description provided for @surfaceColors.
  ///
  /// In en, this message translates to:
  /// **'Surface Colors'**
  String get surfaceColors;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @actionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage your theme settings'**
  String get actionsDescription;

  /// No description provided for @resetToDefault.
  ///
  /// In en, this message translates to:
  /// **'Reset to Default'**
  String get resetToDefault;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @exportSettings.
  ///
  /// In en, this message translates to:
  /// **'Export Settings'**
  String get exportSettings;

  /// No description provided for @importSettings.
  ///
  /// In en, this message translates to:
  /// **'Import Settings'**
  String get importSettings;

  /// No description provided for @shareTheme.
  ///
  /// In en, this message translates to:
  /// **'Share Theme'**
  String get shareTheme;

  /// No description provided for @exportSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Export your current theme settings to clipboard'**
  String get exportSettingsDescription;

  /// No description provided for @importSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Import theme settings from clipboard'**
  String get importSettingsDescription;

  /// No description provided for @shareThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your theme configuration with others'**
  String get shareThemeDescription;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language Changed'**
  String get languageChanged;

  /// No description provided for @languageChangedDescription.
  ///
  /// In en, this message translates to:
  /// **'The language has been changed successfully.'**
  String get languageChangedDescription;

  /// No description provided for @restartNote.
  ///
  /// In en, this message translates to:
  /// **'Note: App restart is required for language changes'**
  String get restartNote;

  /// No description provided for @restartLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get restartLater;

  /// No description provided for @restartNow.
  ///
  /// In en, this message translates to:
  /// **'Restart Now'**
  String get restartNow;

  /// No description provided for @restartAppManually.
  ///
  /// In en, this message translates to:
  /// **'Please restart the app manually to apply language changes'**
  String get restartAppManually;

  /// No description provided for @languageChangeError.
  ///
  /// In en, this message translates to:
  /// **'Failed to change language'**
  String get languageChangeError;

  /// No description provided for @resetConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset to Default'**
  String get resetConfirmationTitle;

  /// No description provided for @resetConfirmationDescription.
  ///
  /// In en, this message translates to:
  /// **'This will reset all theme settings to their default values. This action cannot be undone.'**
  String get resetConfirmationDescription;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export Successful'**
  String get exportSuccess;

  /// No description provided for @exportSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Theme settings copied to clipboard'**
  String get exportSuccessDescription;

  /// No description provided for @exportError.
  ///
  /// In en, this message translates to:
  /// **'Export Failed'**
  String get exportError;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import Successful'**
  String get importSuccess;

  /// No description provided for @importSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Theme settings imported successfully'**
  String get importSuccessDescription;

  /// No description provided for @importError.
  ///
  /// In en, this message translates to:
  /// **'Import Failed'**
  String get importError;

  /// No description provided for @shareError.
  ///
  /// In en, this message translates to:
  /// **'Share Failed'**
  String get shareError;

  /// No description provided for @noClipboardData.
  ///
  /// In en, this message translates to:
  /// **'No data found in clipboard'**
  String get noClipboardData;

  /// No description provided for @invalidThemeData.
  ///
  /// In en, this message translates to:
  /// **'Invalid theme data format'**
  String get invalidThemeData;

  /// No description provided for @invalidThemeFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid theme format'**
  String get invalidThemeFormat;

  /// No description provided for @shareThemeText.
  ///
  /// In en, this message translates to:
  /// **'Check out my awesome theme configuration!'**
  String get shareThemeText;

  /// No description provided for @themeName.
  ///
  /// In en, this message translates to:
  /// **'Theme Name'**
  String get themeName;

  /// No description provided for @themeConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Theme Configuration'**
  String get themeConfiguration;

  /// No description provided for @shareThemeSubject.
  ///
  /// In en, this message translates to:
  /// **'My Theme Configuration'**
  String get shareThemeSubject;
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
    'that was used.',
  );
}
