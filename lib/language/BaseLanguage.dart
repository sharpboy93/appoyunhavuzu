import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage? of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage);

  String get lblCategory;

  String get lblFavourite;

  String get lblViewAll;

  String get lblFeatured;

  String get lblAboutUs;

  String get lblPrivacyPolicy;

  String get lblTermsCondition;

  String get lblContactUs;

  String get lblNoDataFound;

  String get lblNoInternet;

  String get lblLogoutConfirmation;

  String get lblYes;

  String get lblCancel;

  String get lblRateUs;

  String get lblShare;

  String get lblSelectTheme;

  String get lblPushNotification;

  String get lblSearchGame;

  String get lblSetting;

  String get lblSelectLanguage;

  String get lblFollowUs;

  String get lblLight;

  String get lblDark;

  String get lblSystemDefault;
}
