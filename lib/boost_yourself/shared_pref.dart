import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {

  static SharedPreferences? _preferences;

  static const _keyQuoteList = 'quoteList';
  static const _keyDateTimeList = 'dateTimeList';
  static const _keyDailyProgress = 'dailyProgressValue';

  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future setQuoteList(List<String> quoteList) async {
    return await _preferences?.setStringList(_keyQuoteList, quoteList);
  }

  static List<String>? getQuoteList() {
    return _preferences?.getStringList(_keyQuoteList);
  }

  static Future setDateTimeList(List<String> dateTimeList) async {
    return await _preferences?.setStringList(_keyDateTimeList, dateTimeList);
  }

  static List<String>? getDateTimeList() {
    return _preferences?.getStringList(_keyDateTimeList);
  }

  // ---------------- gritie features -------------------

  static const _keyIsWelcomed = 'welcome';
  static const _keyUserName = 'userName';

  static Future<bool?> setIsWelcomed(bool isWelcomed) async {
    return await _preferences?.setBool(_keyIsWelcomed, isWelcomed);
  }

  static bool getIsWelcomed() {
    return _preferences?.getBool(_keyIsWelcomed) ?? false;
  }
  
  static Future<bool?> setUserName(String userName) async {
    print('userName ' +  userName.toString());
    return await _preferences?.setString(_keyUserName, userName);
  }

  static String? getUserName() {
    return _preferences?.getString(_keyUserName);
  }

  static Future<bool> setDailyProgress(double dailyProgress) async {
    print('dailyProgressShared $dailyProgress');
    return await _preferences!.setDouble(_keyDailyProgress, dailyProgress);
  }

  static double? getDailyProgress() {
    return _preferences?.getDouble(_keyDailyProgress) ?? 0.0;
  }


}