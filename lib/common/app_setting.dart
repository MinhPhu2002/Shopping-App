import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'package:testapp/common/repo/app_setting_repo.dart';

abstract class AppSetting {
  static final ValueNotifier<bool> _isdarkthemeNotifier = ValueNotifier(false);
  static ValueListenable<bool> get isdarkthemeNotifier => _isdarkthemeNotifier;
  static Future<void> ensureInitialized() async {
    await SpUtil.getInstance();
    _isdarkthemeNotifier.value = AppSettingRepo.getDarkMode();
  }

  static void enableDarkMode() {
    _isdarkthemeNotifier.value = true;
    AppSettingRepo.saveDarkMode(true);
  }

  static void disableDarkMode() {
    _isdarkthemeNotifier.value = false;
    AppSettingRepo.saveDarkMode(false);
  }
}
