import 'package:sp_util/sp_util.dart';

const String _isdarkmodekey = 'darkmode';

class AppSettingRepo {
  static void saveDarkMode(value) {
    SpUtil.putBool(_isdarkmodekey, value);
  }

  static bool getDarkMode() {
    return SpUtil.getBool(_isdarkmodekey, defValue: false)!;
  }
}
