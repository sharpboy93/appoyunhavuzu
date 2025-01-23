import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../language/AppLocalizations.dart';
import '../language/BaseLanguage.dart';
import '../main.dart';
import '../model/LanguageDataModel.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/device_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isDarkModeOn = false;

  @observable
  bool isLoading = false;

  @observable
  bool isNotificationOn = false;

  @observable
  String selectedLanguage = "";

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkModeOn = aIsDarkMode;

    if (isDarkModeOn) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = viewLineColor;
      defaultLoaderBgColorGlobal = Colors.black26;
      defaultLoaderAccentColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.white12;
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;
      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = primaryColor;
      shadowColorGlobal = Colors.black12;
    }
  }

  @action
  void setNotification(bool val) {
    isNotificationOn = val;
    setValue(IS_NOTIFICATION_ON, val);

    if (isMobile) {
      // OneSignal.shared.disablePush(!val);
      OneSignal.User.pushSubscription.optOut();

    }
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
    // setValue(IS_NOTIFICATION_ON, val);
  }

  @action
  Future<void> setLanguage(String aCode, {BuildContext? context}) async {
    selectedLanguageDataModel = getSelectedLanguageModel(defaultLanguage: aCode);
    selectedLanguage = getSelectedLanguageModel(defaultLanguage: defaultValues.defaultLanguage)!.languageCode!;

    if (context != null) language = BaseLanguage.of(context)!;
    language = await AppLocalizations().load(Locale(selectedLanguage));
  }
}
