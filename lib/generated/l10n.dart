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

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
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

  /// `Verify your email to complete your registration process via sending verification email.`
  String get verificationText {
    return Intl.message(
      'Verify your email to complete your registration process via sending verification email.',
      name: 'verificationText',
      desc: '',
      args: [],
    );
  }

  /// `Verification email is sent successfully! Please check your inbox.`
  String get verificationEmailSent {
    return Intl.message(
      'Verification email is sent successfully! Please check your inbox.',
      name: 'verificationEmailSent',
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

  /// `Email Address`
  String get emailPlaceholder {
    return Intl.message(
      'Email Address',
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

  /// `Firstname`
  String get firstNamePLaceholder {
    return Intl.message(
      'Firstname',
      name: 'firstNamePLaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Lastname`
  String get lastNamePLaceholder {
    return Intl.message(
      'Lastname',
      name: 'lastNamePLaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Fullname`
  String get fullNamePLaceholder {
    return Intl.message(
      'Fullname',
      name: 'fullNamePLaceholder',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get nationalIdPlaceholder {
    return Intl.message(
      'National ID',
      name: 'nationalIdPlaceholder',
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

  /// `National Id field is required!`
  String get requiredNationalId {
    return Intl.message(
      'National Id field is required!',
      name: 'requiredNationalId',
      desc: '',
      args: [],
    );
  }

  /// `National id consists of 14 digits and doesn't start with zero!`
  String get invalidNationalId {
    return Intl.message(
      'National id consists of 14 digits and doesn\'t start with zero!',
      name: 'invalidNationalId',
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

  /// `Partners`
  String get partners {
    return Intl.message('Partners', name: 'partners', desc: '', args: []);
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

  /// `BECOME INVESTOR`
  String get becomeInvestorWithUs {
    return Intl.message(
      'BECOME INVESTOR',
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

  /// `Reset password email is sent successfully. check you inbox!`
  String get forgotPasswordResponse {
    return Intl.message(
      'Reset password email is sent successfully. check you inbox!',
      name: 'forgotPasswordResponse',
      desc: '',
      args: [],
    );
  }

  /// `One property saved successfully!`
  String get addToFavouritesResponse {
    return Intl.message(
      'One property saved successfully!',
      name: 'addToFavouritesResponse',
      desc: '',
      args: [],
    );
  }

  /// `You are about to delete the property `
  String get deleteSinglePopupTextPart1 {
    return Intl.message(
      'You are about to delete the property ',
      name: 'deleteSinglePopupTextPart1',
      desc: '',
      args: [],
    );
  }

  /// ` from the savings list, are you sure about your decision ?`
  String get deleteSinglePopupTextPart2 {
    return Intl.message(
      ' from the savings list, are you sure about your decision ?',
      name: 'deleteSinglePopupTextPart2',
      desc: '',
      args: [],
    );
  }

  /// `Delete operation is done successfully!`
  String get deleteOperationSuccess {
    return Intl.message(
      'Delete operation is done successfully!',
      name: 'deleteOperationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Start Investment!`
  String get startInvestment {
    return Intl.message(
      'Start Investment!',
      name: 'startInvestment',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Search Results:`
  String get searchResults {
    return Intl.message(
      'Search Results:',
      name: 'searchResults',
      desc: '',
      args: [],
    );
  }

  /// `User avatar updated successfully!`
  String get userAvatarSuccessMessage {
    return Intl.message(
      'User avatar updated successfully!',
      name: 'userAvatarSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Last Transactions :`
  String get lastTransactions {
    return Intl.message(
      'Last Transactions :',
      name: 'lastTransactions',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get all {
    return Intl.message('ALL', name: 'all', desc: '', args: []);
  }

  /// `There is no transactions yet!`
  String get noTransactionsYet {
    return Intl.message(
      'There is no transactions yet!',
      name: 'noTransactionsYet',
      desc: '',
      args: [],
    );
  }

  /// `PENDING`
  String get pending {
    return Intl.message('PENDING', name: 'pending', desc: '', args: []);
  }

  /// `PAID`
  String get paid {
    return Intl.message('PAID', name: 'paid', desc: '', args: []);
  }

  /// `DECLINED`
  String get declined {
    return Intl.message('DECLINED', name: 'declined', desc: '', args: []);
  }

  /// `INSTAPAY`
  String get instaPay {
    return Intl.message('INSTAPAY', name: 'instaPay', desc: '', args: []);
  }

  /// `VODAFONE CASH`
  String get vodafoneCash {
    return Intl.message(
      'VODAFONE CASH',
      name: 'vodafoneCash',
      desc: '',
      args: [],
    );
  }

  /// `BANK`
  String get bankTransfer {
    return Intl.message('BANK', name: 'bankTransfer', desc: '', args: []);
  }

  /// `Transfer the money for the following number: 01016868492`
  String get paymentFormTextPart1 {
    return Intl.message(
      'Transfer the money for the following number: 01016868492',
      name: 'paymentFormTextPart1',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amountPlaceholder {
    return Intl.message(
      'Amount',
      name: 'amountPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Screenshot`
  String get screenshotPlaceholder {
    return Intl.message(
      'Screenshot',
      name: 'screenshotPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Amount field is required!`
  String get requiredAmount {
    return Intl.message(
      'Amount field is required!',
      name: 'requiredAmount',
      desc: '',
      args: [],
    );
  }

  /// `The amount should be at least 1000!`
  String get invalidAmount {
    return Intl.message(
      'The amount should be at least 1000!',
      name: 'invalidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Payment operation done successfully!`
  String get successfullPayment {
    return Intl.message(
      'Payment operation done successfully!',
      name: 'successfullPayment',
      desc: '',
      args: [],
    );
  }

  /// `Upload Bill`
  String get uploadBill {
    return Intl.message('Upload Bill', name: 'uploadBill', desc: '', args: []);
  }

  /// `You must upload a screenshot for the bill!`
  String get uploadBillMessage {
    return Intl.message(
      'You must upload a screenshot for the bill!',
      name: 'uploadBillMessage',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Email sent successfully! Please follow you inbox.`
  String get contactUsSuccess {
    return Intl.message(
      'Email sent successfully! Please follow you inbox.',
      name: 'contactUsSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Subject field is required!`
  String get requiredSubject {
    return Intl.message(
      'Subject field is required!',
      name: 'requiredSubject',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subjectPlaceholder {
    return Intl.message(
      'Subject',
      name: 'subjectPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Pin field is required!`
  String get requiredPin {
    return Intl.message(
      'Pin field is required!',
      name: 'requiredPin',
      desc: '',
      args: [],
    );
  }

  /// `PIN code consists of 6 digits doesn't start with 0!`
  String get invalidPin {
    return Intl.message(
      'PIN code consists of 6 digits doesn\'t start with 0!',
      name: 'invalidPin',
      desc: '',
      args: [],
    );
  }

  /// `Credit card number`
  String get creditPlaceholder {
    return Intl.message(
      'Credit card number',
      name: 'creditPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Instapay account`
  String get instapayPlaceholder {
    return Intl.message(
      'Instapay account',
      name: 'instapayPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Amount must be greater than 0`
  String get invalidAmount2 {
    return Intl.message(
      'Amount must be greater than 0',
      name: 'invalidAmount2',
      desc: '',
      args: [],
    );
  }

  /// `Credit card number is required!`
  String get requiredCredit {
    return Intl.message(
      'Credit card number is required!',
      name: 'requiredCredit',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credit/debit card number!`
  String get invalidCredit {
    return Intl.message(
      'Invalid credit/debit card number!',
      name: 'invalidCredit',
      desc: '',
      args: [],
    );
  }

  /// `Instapay account is required!`
  String get requiredInstapay {
    return Intl.message(
      'Instapay account is required!',
      name: 'requiredInstapay',
      desc: '',
      args: [],
    );
  }

  /// `Your account must end with @instapay`
  String get invalidInstapay {
    return Intl.message(
      'Your account must end with @instapay',
      name: 'invalidInstapay',
      desc: '',
      args: [],
    );
  }

  /// `Vodafone numbers start with 010 and consists of 11 digits!`
  String get invalidVodafone {
    return Intl.message(
      'Vodafone numbers start with 010 and consists of 11 digits!',
      name: 'invalidVodafone',
      desc: '',
      args: [],
    );
  }

  /// `Fullname field is required!`
  String get requiredFullname {
    return Intl.message(
      'Fullname field is required!',
      name: 'requiredFullname',
      desc: '',
      args: [],
    );
  }

  /// `Fullname consists of at least 3 characters!`
  String get invalidFullname {
    return Intl.message(
      'Fullname consists of at least 3 characters!',
      name: 'invalidFullname',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get egp {
    return Intl.message('EGP', name: 'egp', desc: '', args: []);
  }

  /// `EGP/Share`
  String get egpPerShare {
    return Intl.message('EGP/Share', name: 'egpPerShare', desc: '', args: []);
  }

  /// `EGP/Year`
  String get egpPerYear {
    return Intl.message('EGP/Year', name: 'egpPerYear', desc: '', args: []);
  }

  /// `Investment operation is done successfully!`
  String get investmentSuccess {
    return Intl.message(
      'Investment operation is done successfully!',
      name: 'investmentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message('Available', name: 'available', desc: '', args: []);
  }

  /// `Funded`
  String get funded {
    return Intl.message('Funded', name: 'funded', desc: '', args: []);
  }

  /// `Exited`
  String get exited {
    return Intl.message('Exited', name: 'exited', desc: '', args: []);
  }

  /// `Rented`
  String get rented {
    return Intl.message('Rented', name: 'rented', desc: '', args: []);
  }

  /// `Squared Meters`
  String get squaredMeters {
    return Intl.message(
      'Squared Meters',
      name: 'squaredMeters',
      desc: '',
      args: [],
    );
  }

  /// `Visit`
  String get visit {
    return Intl.message('Visit', name: 'visit', desc: '', args: []);
  }

  /// `Shares:`
  String get sharesSeciton {
    return Intl.message('Shares:', name: 'sharesSeciton', desc: '', args: []);
  }

  /// `Rooms:`
  String get roomsSeciton {
    return Intl.message('Rooms:', name: 'roomsSeciton', desc: '', args: []);
  }

  /// `Rental Incomes:`
  String get rentalSeciton {
    return Intl.message(
      'Rental Incomes:',
      name: 'rentalSeciton',
      desc: '',
      args: [],
    );
  }

  /// `Benefits:`
  String get benefitsSeciton {
    return Intl.message(
      'Benefits:',
      name: 'benefitsSeciton',
      desc: '',
      args: [],
    );
  }

  /// `Invest NOW!`
  String get investNow {
    return Intl.message('Invest NOW!', name: 'investNow', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Price/Share`
  String get priceShare {
    return Intl.message('Price/Share', name: 'priceShare', desc: '', args: []);
  }

  /// `Price per share`
  String get pricePerShare {
    return Intl.message(
      'Price per share',
      name: 'pricePerShare',
      desc: '',
      args: [],
    );
  }

  /// `Payment per year`
  String get paymentPerYear {
    return Intl.message(
      'Payment per year',
      name: 'paymentPerYear',
      desc: '',
      args: [],
    );
  }

  /// `Available Shares`
  String get availableShares {
    return Intl.message(
      'Available Shares',
      name: 'availableShares',
      desc: '',
      args: [],
    );
  }

  /// `Price Sold`
  String get priceSold {
    return Intl.message('Price Sold', name: 'priceSold', desc: '', args: []);
  }

  /// `Shares`
  String get shares {
    return Intl.message('Shares', name: 'shares', desc: '', args: []);
  }

  /// `Estimated to exit on`
  String get estimatedExitdate {
    return Intl.message(
      'Estimated to exit on',
      name: 'estimatedExitdate',
      desc: '',
      args: [],
    );
  }

  /// `Rooms`
  String get rooms {
    return Intl.message('Rooms', name: 'rooms', desc: '', args: []);
  }

  /// `Bathrooms`
  String get bathrooms {
    return Intl.message('Bathrooms', name: 'bathrooms', desc: '', args: []);
  }

  /// `Beds`
  String get beds {
    return Intl.message('Beds', name: 'beds', desc: '', args: []);
  }

  /// `Kitchens`
  String get kitchens {
    return Intl.message('Kitchens', name: 'kitchens', desc: '', args: []);
  }

  /// `Rental Name`
  String get rentalName {
    return Intl.message('Rental Name', name: 'rentalName', desc: '', args: []);
  }

  /// `Income`
  String get income {
    return Intl.message('Income', name: 'income', desc: '', args: []);
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Partner doesn't have properties!`
  String get emptyPartnerProperties {
    return Intl.message(
      'Partner doesn\'t have properties!',
      name: 'emptyPartnerProperties',
      desc: '',
      args: [],
    );
  }

  /// `Month/Day`
  String get monthDay {
    return Intl.message('Month/Day', name: 'monthDay', desc: '', args: []);
  }

  /// `Number of shares`
  String get numberOfShares {
    return Intl.message(
      'Number of shares',
      name: 'numberOfShares',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Total Investments`
  String get totalInvestments {
    return Intl.message(
      'Total Investments',
      name: 'totalInvestments',
      desc: '',
      args: [],
    );
  }

  /// `There are no investments yet, start investing in some property!`
  String get emptyInvetsments {
    return Intl.message(
      'There are no investments yet, start investing in some property!',
      name: 'emptyInvetsments',
      desc: '',
      args: [],
    );
  }

  /// `You are not Investor yet! you need to become investor first.`
  String get notInvestorYet {
    return Intl.message(
      'You are not Investor yet! you need to become investor first.',
      name: 'notInvestorYet',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `Partner's Properties:`
  String get propertiesOfPartners {
    return Intl.message(
      'Partner\'s Properties:',
      name: 'propertiesOfPartners',
      desc: '',
      args: [],
    );
  }

  /// `No results exist!`
  String get noResults {
    return Intl.message(
      'No results exist!',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Hey`
  String get overlayTextPart1 {
    return Intl.message('Hey', name: 'overlayTextPart1', desc: '', args: []);
  }

  /// `, ask me anything`
  String get overlayTextPart2 {
    return Intl.message(
      ', ask me anything',
      name: 'overlayTextPart2',
      desc: '',
      args: [],
    );
  }

  /// `Bedrooms`
  String get bedrooms {
    return Intl.message('Bedrooms', name: 'bedrooms', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `UNIT`
  String get unit {
    return Intl.message('UNIT', name: 'unit', desc: '', args: []);
  }

  /// `Rental Income`
  String get rentalIncome {
    return Intl.message(
      'Rental Income',
      name: 'rentalIncome',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message('Area', name: 'area', desc: '', args: []);
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `There are no notifications yet!`
  String get noNotificationsYet {
    return Intl.message(
      'There are no notifications yet!',
      name: 'noNotificationsYet',
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
