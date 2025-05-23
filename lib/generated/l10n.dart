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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Invest in your favourite properties`
  String get onboardingTitle {
    return Intl.message(
      'Invest in your favourite properties',
      name: 'onboardingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Profile Settings`
  String get profileSettings {
    return Intl.message(
      'Profile Settings',
      name: 'profileSettings',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy & Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message('Log Out', name: 'logout', desc: '', args: []);
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
  }

  /// `Expenses`
  String get expenses {
    return Intl.message('Expenses', name: 'expenses', desc: '', args: []);
  }

  /// `Incomes`
  String get incomes {
    return Intl.message('Incomes', name: 'incomes', desc: '', args: []);
  }

  /// `CURRENT BALANCE`
  String get currentBalance {
    return Intl.message(
      'CURRENT BALANCE',
      name: 'currentBalance',
      desc: '',
      args: [],
    );
  }

  /// `Enter 6-Digit Password`
  String get passowrdDialog {
    return Intl.message(
      'Enter 6-Digit Password',
      name: 'passowrdDialog',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `DEPOSIT`
  String get deposit {
    return Intl.message('DEPOSIT', name: 'deposit', desc: '', args: []);
  }

  /// `WITHDRAW`
  String get withdraw {
    return Intl.message('WITHDRAW', name: 'withdraw', desc: '', args: []);
  }

  /// `Pay Shares`
  String get payShares {
    return Intl.message('Pay Shares', name: 'payShares', desc: '', args: []);
  }

  /// `Fees`
  String get fees {
    return Intl.message('Fees', name: 'fees', desc: '', args: []);
  }

  /// `Rent`
  String get rent {
    return Intl.message('Rent', name: 'rent', desc: '', args: []);
  }

  /// `Bonus`
  String get bonus {
    return Intl.message('Bonus', name: 'bonus', desc: '', args: []);
  }

  /// `Withdrawal`
  String get withdrawal {
    return Intl.message('Withdrawal', name: 'withdrawal', desc: '', args: []);
  }

  /// `Deposit`
  String get depositFee {
    return Intl.message('Deposit', name: 'depositFee', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot {
    return Intl.message('Forgot Password?', name: 'forgot', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkmode {
    return Intl.message('Dark Mode', name: 'darkmode', desc: '', args: []);
  }

  /// `Arabic`
  String get locale {
    return Intl.message('Arabic', name: 'locale', desc: '', args: []);
  }

  /// `I forgot my password`
  String get forgotPassword {
    return Intl.message(
      'I forgot my password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Provide us with your email then check your inbox for the verification email.`
  String get forgotPasswordText {
    return Intl.message(
      'Provide us with your email then check your inbox for the verification email.',
      name: 'forgotPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit code you received in the inbox of `
  String get verificationText {
    return Intl.message(
      'Enter the 6-digit code you received in the inbox of ',
      name: 'verificationText',
      desc: '',
      args: [],
    );
  }

  /// `I have an account?`
  String get haveAccount {
    return Intl.message(
      'I have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `register`
  String get registerUser {
    return Intl.message('register', name: 'registerUser', desc: '', args: []);
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Register`
  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  /// `Send`
  String get sendButton {
    return Intl.message('Send', name: 'sendButton', desc: '', args: []);
  }

  /// `Verify`
  String get verifyButton {
    return Intl.message('Verify', name: 'verifyButton', desc: '', args: []);
  }

  /// `Enter your email to continue..`
  String get emailPlaceholder {
    return Intl.message(
      'Enter your email to continue..',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordPlaceholder {
    return Intl.message(
      'Password',
      name: 'passwordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get usernamePlaceholder {
    return Intl.message(
      'Username',
      name: 'usernamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Phone No.`
  String get phonePlaceholder {
    return Intl.message(
      'Phone No.',
      name: 'phonePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Email field is required!`
  String get requiredEmail {
    return Intl.message(
      'Email field is required!',
      name: 'requiredEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email Address!`
  String get invalidEmail {
    return Intl.message(
      'Invalid email Address!',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password Field is required!`
  String get requiredPassword {
    return Intl.message(
      'Password Field is required!',
      name: 'requiredPassword',
      desc: '',
      args: [],
    );
  }

  /// `Requires at least 8 characters, including uppercase, lowercase, digits, and special characters.`
  String get invalidPassword {
    return Intl.message(
      'Requires at least 8 characters, including uppercase, lowercase, digits, and special characters.',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Username field is required!`
  String get requiredUsername {
    return Intl.message(
      'Username field is required!',
      name: 'requiredUsername',
      desc: '',
      args: [],
    );
  }

  /// `Requires at least 3 characters!`
  String get invalidUsername {
    return Intl.message(
      'Requires at least 3 characters!',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `Phone field is required!`
  String get requiredPhone {
    return Intl.message(
      'Phone field is required!',
      name: 'requiredPhone',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Phone Number!`
  String get invalidPhone {
    return Intl.message(
      'Invalid Phone Number!',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Otp field is required!`
  String get requiredOtp {
    return Intl.message(
      'Otp field is required!',
      name: 'requiredOtp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid otp code!`
  String get invalidOtp {
    return Intl.message(
      'Invalid otp code!',
      name: 'invalidOtp',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hello {
    return Intl.message('Hello!', name: 'hello', desc: '', args: []);
  }

  /// `Search...`
  String get search {
    return Intl.message('Search...', name: 'search', desc: '', args: []);
  }

  /// `Best For You`
  String get bestForYou {
    return Intl.message('Best For You', name: 'bestForYou', desc: '', args: []);
  }

  /// `Developers`
  String get developers {
    return Intl.message('Developers', name: 'developers', desc: '', args: []);
  }

  /// `New Added`
  String get newAdded {
    return Intl.message('New Added', name: 'newAdded', desc: '', args: []);
  }

  /// `Best Invest`
  String get bestInvest {
    return Intl.message('Best Invest', name: 'bestInvest', desc: '', args: []);
  }

  /// `Rest Of Properties`
  String get restOfProperties {
    return Intl.message(
      'Rest Of Properties',
      name: 'restOfProperties',
      desc: '',
      args: [],
    );
  }

  /// ` Properties`
  String get properties {
    return Intl.message(' Properties', name: 'properties', desc: '', args: []);
  }

  /// `HOT`
  String get hot {
    return Intl.message('HOT', name: 'hot', desc: '', args: []);
  }

  /// `Personal Profile`
  String get personalProfile {
    return Intl.message(
      'Personal Profile',
      name: 'personalProfile',
      desc: '',
      args: [],
    );
  }

  /// `The pin number changed successfully!`
  String get pinDialog {
    return Intl.message(
      'The pin number changed successfully!',
      name: 'pinDialog',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get changePin {
    return Intl.message('Change PIN', name: 'changePin', desc: '', args: []);
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Become investor with us`
  String get becomeInvestorWithUs {
    return Intl.message(
      'Become investor with us',
      name: 'becomeInvestorWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Enter new PIN number for your wallet`
  String get pinMessage {
    return Intl.message(
      'Enter new PIN number for your wallet',
      name: 'pinMessage',
      desc: '',
      args: [],
    );
  }

  /// `The new pin number is similar to the old one. try another one!`
  String get pinError {
    return Intl.message(
      'The new pin number is similar to the old one. try another one!',
      name: 'pinError',
      desc: '',
      args: [],
    );
  }

  /// `Feel free to reach out via our official email, and we’ll respond as soon as possible (within 24 hours).`
  String get contactUsText {
    return Intl.message(
      'Feel free to reach out via our official email, and we’ll respond as soon as possible (within 24 hours).',
      name: 'contactUsText',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get messagePlaceholder {
    return Intl.message(
      'Message',
      name: 'messagePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Message field is required!`
  String get requiredMessage {
    return Intl.message(
      'Message field is required!',
      name: 'requiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Become Investor`
  String get becomeInvestor {
    return Intl.message(
      'Become Investor',
      name: 'becomeInvestor',
      desc: '',
      args: [],
    );
  }

  /// `You are already an investor, start your investing journey!`
  String get becomeInvestorText {
    return Intl.message(
      'You are already an investor, start your investing journey!',
      name: 'becomeInvestorText',
      desc: '',
      args: [],
    );
  }

  /// `Once you save the information, you are agreed to the terms & conditions.`
  String get becomInvestorNote {
    return Intl.message(
      'Once you save the information, you are agreed to the terms & conditions.',
      name: 'becomInvestorNote',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! You are now an investor. you can start investing now in our platform.`
  String get becomeInvestorPopup {
    return Intl.message(
      'Congratulations! You are now an investor. you can start investing now in our platform.',
      name: 'becomeInvestorPopup',
      desc: '',
      args: [],
    );
  }

  /// `My Investments`
  String get myInvestments {
    return Intl.message(
      'My Investments',
      name: 'myInvestments',
      desc: '',
      args: [],
    );
  }

  /// `Saved Properties`
  String get savedProperties {
    return Intl.message(
      'Saved Properties',
      name: 'savedProperties',
      desc: '',
      args: [],
    );
  }

  /// `You are about to delete the selected saved properties, are you sure about your decision?`
  String get deleteDialogText {
    return Intl.message(
      'You are about to delete the selected saved properties, are you sure about your decision?',
      name: 'deleteDialogText',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Add some favourite properties.`
  String get emptyFavourites {
    return Intl.message(
      'Add some favourite properties.',
      name: 'emptyFavourites',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
