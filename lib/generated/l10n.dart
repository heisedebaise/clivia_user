// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unset`
  String get unset {
    return Intl.message(
      'Unset',
      name: 'unset',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please set a nickname`
  String get meSignNickEmpty {
    return Intl.message(
      'Please set a nickname',
      name: 'meSignNickEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get meSignInfo {
    return Intl.message(
      'Personal Information',
      name: 'meSignInfo',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get meSignAvatar {
    return Intl.message(
      'Avatar',
      name: 'meSignAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Change Avatar`
  String get meSignAvatarChange {
    return Intl.message(
      'Change Avatar',
      name: 'meSignAvatarChange',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get meSignNick {
    return Intl.message(
      'Nickname',
      name: 'meSignNick',
      desc: '',
      args: [],
    );
  }

  /// `Change Nickname`
  String get meSignNickChange {
    return Intl.message(
      'Change Nickname',
      name: 'meSignNickChange',
      desc: '',
      args: [],
    );
  }

  /// `A personalized nickname can make it easier for your friends to remember you`
  String get meSignNickChangeMemo {
    return Intl.message(
      'A personalized nickname can make it easier for your friends to remember you',
      name: 'meSignNickChangeMemo',
      desc: '',
      args: [],
    );
  }

  /// `Gesture Password`
  String get meSignGesture {
    return Intl.message(
      'Gesture Password',
      name: 'meSignGesture',
      desc: '',
      args: [],
    );
  }

  /// `Enable gesture password`
  String get meSignGestureOn {
    return Intl.message(
      'Enable gesture password',
      name: 'meSignGestureOn',
      desc: '',
      args: [],
    );
  }

  /// `Turn off gesture password`
  String get meSignGestureOff {
    return Intl.message(
      'Turn off gesture password',
      name: 'meSignGestureOff',
      desc: '',
      args: [],
    );
  }

  /// `Wrong gesture password!`
  String get meSignGestureWrong {
    return Intl.message(
      'Wrong gesture password!',
      name: 'meSignGestureWrong',
      desc: '',
      args: [],
    );
  }

  /// `Same as gesture password!`
  String get meSignGestureSame {
    return Intl.message(
      'Same as gesture password!',
      name: 'meSignGestureSame',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get meSignMobile {
    return Intl.message(
      'Mobile',
      name: 'meSignMobile',
      desc: '',
      args: [],
    );
  }

  /// `Change Mobile`
  String get meSignMobileChange {
    return Intl.message(
      'Change Mobile',
      name: 'meSignMobileChange',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get meSignEmail {
    return Intl.message(
      'Email',
      name: 'meSignEmail',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get meSignEmailChange {
    return Intl.message(
      'Change Email',
      name: 'meSignEmailChange',
      desc: '',
      args: [],
    );
  }

  /// `QR Code Business Card`
  String get meSignQrCode {
    return Intl.message(
      'QR Code Business Card',
      name: 'meSignQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Destroy password`
  String get meSignDestroy {
    return Intl.message(
      'Destroy password',
      name: 'meSignDestroy',
      desc: '',
      args: [],
    );
  }

  /// `Enable destroy password`
  String get meSignDestroyOn {
    return Intl.message(
      'Enable destroy password',
      name: 'meSignDestroyOn',
      desc: '',
      args: [],
    );
  }

  /// `Turn off destroy password`
  String get meSignDestroyOff {
    return Intl.message(
      'Turn off destroy password',
      name: 'meSignDestroyOff',
      desc: '',
      args: [],
    );
  }

  /// `Wrong destroy password!`
  String get meSignDestroyWrong {
    return Intl.message(
      'Wrong destroy password!',
      name: 'meSignDestroyWrong',
      desc: '',
      args: [],
    );
  }

  /// `Enter the destroy password when logging in or unlocking the screen, and the account will be automatically destroyed immediately!`
  String get meSignDestroyMemo {
    return Intl.message(
      'Enter the destroy password when logging in or unlocking the screen, and the account will be automatically destroyed immediately!',
      name: 'meSignDestroyMemo',
      desc: '',
      args: [],
    );
  }

  /// `Destroy account`
  String get meSignDestroyAccount {
    return Intl.message(
      'Destroy account',
      name: 'meSignDestroyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Account information will be completely deleted after logout and cannot be recovered!`
  String get meSignDestroyAccountMemo {
    return Intl.message(
      'Account information will be completely deleted after logout and cannot be recovered!',
      name: 'meSignDestroyAccountMemo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your login password`
  String get meSignDestroyPassword {
    return Intl.message(
      'Please enter your login password',
      name: 'meSignDestroyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Same as destroy password!`
  String get meSignDestroySame {
    return Intl.message(
      'Same as destroy password!',
      name: 'meSignDestroySame',
      desc: '',
      args: [],
    );
  }

  /// `I have read and agree to the Privacy Agreement`
  String get meSignUpPrivacyAgreement {
    return Intl.message(
      'I have read and agree to the Privacy Agreement',
      name: 'meSignUpPrivacyAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get meSignUp {
    return Intl.message(
      'Sign Up',
      name: 'meSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get meSignIn {
    return Intl.message(
      'Sign In',
      name: 'meSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the gesture password`
  String get meSignInGesture {
    return Intl.message(
      'Please enter the gesture password',
      name: 'meSignInGesture',
      desc: '',
      args: [],
    );
  }

  /// `Retreat safely`
  String get meSignOut {
    return Intl.message(
      'Retreat safely',
      name: 'meSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username`
  String get meSignUsername {
    return Intl.message(
      'Please enter your username',
      name: 'meSignUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password`
  String get meSignPassword {
    return Intl.message(
      'Please enter the password',
      name: 'meSignPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password again`
  String get meSignPasswordRepeat {
    return Intl.message(
      'Please enter the password again',
      name: 'meSignPasswordRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password!`
  String get meSignPasswordWrong {
    return Intl.message(
      'Wrong password!',
      name: 'meSignPasswordWrong',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get meSignPasswordForget {
    return Intl.message(
      'Forgot password',
      name: 'meSignPasswordForget',
      desc: '',
      args: [],
    );
  }

  /// `Take a personal nickname`
  String get meSignNickNew {
    return Intl.message(
      'Take a personal nickname',
      name: 'meSignNickNew',
      desc: '',
      args: [],
    );
  }

  /// `Register a new account`
  String get meSignToUp {
    return Intl.message(
      'Register a new account',
      name: 'meSignToUp',
      desc: '',
      args: [],
    );
  }

  /// `I already have an account`
  String get meSignToIn {
    return Intl.message(
      'I already have an account',
      name: 'meSignToIn',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get meLanguage {
    return Intl.message(
      'Language',
      name: 'meLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select your language`
  String get meLanguageSelect {
    return Intl.message(
      'Select your language',
      name: 'meLanguageSelect',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get meSettings {
    return Intl.message(
      'Settings',
      name: 'meSettings',
      desc: '',
      args: [],
    );
  }

  /// `Automatically lock screen`
  String get meSettingsLockScreen {
    return Intl.message(
      'Automatically lock screen',
      name: 'meSettingsLockScreen',
      desc: '',
      args: [],
    );
  }

  /// `Enable automatic screen lock`
  String get meSettingsLockScreenOn {
    return Intl.message(
      'Enable automatic screen lock',
      name: 'meSettingsLockScreenOn',
      desc: '',
      args: [],
    );
  }

  /// `Turn off automatic screen lock`
  String get meSettingsLockScreenOff {
    return Intl.message(
      'Turn off automatic screen lock',
      name: 'meSettingsLockScreenOff',
      desc: '',
      args: [],
    );
  }

  /// `Lock screen password`
  String get meSettingsLockScreenPassword {
    return Intl.message(
      'Lock screen password',
      name: 'meSettingsLockScreenPassword',
      desc: '',
      args: [],
    );
  }

  /// `Lock screen password wrong`
  String get meSettingsLockScreenWrong {
    return Intl.message(
      'Lock screen password wrong',
      name: 'meSettingsLockScreenWrong',
      desc: '',
      args: [],
    );
  }

  /// `Same as lock screen password!`
  String get meSettingsLockScreenSame {
    return Intl.message(
      'Same as lock screen password!',
      name: 'meSettingsLockScreenSame',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get meSettingsDark {
    return Intl.message(
      'Dark mode',
      name: 'meSettingsDark',
      desc: '',
      args: [],
    );
  }

  /// `The interface is mainly black, which helps to save power and reduce the damage of light to the eyes`
  String get meSettingsDarkExplain {
    return Intl.message(
      'The interface is mainly black, which helps to save power and reduce the damage of light to the eyes',
      name: 'meSettingsDarkExplain',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get meFeedback {
    return Intl.message(
      'Feedback',
      name: 'meFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Your comments and suggestions are very important to us, thank you very much for your support!`
  String get meFeedbackMemo {
    return Intl.message(
      'Your comments and suggestions are very important to us, thank you very much for your support!',
      name: 'meFeedbackMemo',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get meFeedbackSubmit {
    return Intl.message(
      'Submit',
      name: 'meFeedbackSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get meVersion {
    return Intl.message(
      'Version',
      name: 'meVersion',
      desc: '',
      args: [],
    );
  }

  /// `Go to update`
  String get meVersionForward {
    return Intl.message(
      'Go to update',
      name: 'meVersionForward',
      desc: '',
      args: [],
    );
  }

  /// `Upload Log`
  String get meUploadLog {
    return Intl.message(
      'Upload Log',
      name: 'meUploadLog',
      desc: '',
      args: [],
    );
  }

  /// `The uploaded log is only used to find bugs and will be deleted immediately after troubleshooting. Thank you very much for your support!`
  String get meUploadLogMemo {
    return Intl.message(
      'The uploaded log is only used to find bugs and will be deleted immediately after troubleshooting. Thank you very much for your support!',
      name: 'meUploadLogMemo',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Agreement`
  String get mePrivacyAgreement {
    return Intl.message(
      'Privacy Agreement',
      name: 'mePrivacyAgreement',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get meAboutUs {
    return Intl.message(
      'About Us',
      name: 'meAboutUs',
      desc: '',
      args: [],
    );
  }

  /// `unknow error!`
  String get failure {
    return Intl.message(
      'unknow error!',
      name: 'failure',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
