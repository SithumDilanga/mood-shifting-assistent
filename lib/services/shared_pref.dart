// import 'package:shared_preferences/shared_preferences.dart';


// class SharedPref {

//   static SharedPreferences? _preferences;

//   static const _keyDailyProgress = 'dailyProgressValue';

//   static Future init() async {
//     return _preferences = await SharedPreferences.getInstance();
//   }

//   static Future<bool> setDailyProgress(double dailyProgress) async {
//     return await _preferences!.setDouble(_keyDailyProgress, dailyProgress);
//   }

//   static double? getDailyProgress() {
//     return _preferences?.getDouble(_keyDailyProgress) ?? 0.0;
//   }

// }