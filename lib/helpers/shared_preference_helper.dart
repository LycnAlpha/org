import 'package:org_connect_pt/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  //For saving auth and refresh tokens
  static Future<bool> saveAuthToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(Constants.authToken, token);
  }

  static Future<String> getAuthToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(Constants.authToken) ?? '';
  }

  static Future<bool> saverRefreshToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(Constants.refreshToken, token);
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(Constants.refreshToken) ?? '';
  }

  //For saving permission level
  static Future<bool> savePermissionLevel(int level) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(Constants.permissionLevel, level);
  }

  static Future<int> getPermissionLevel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(Constants.permissionLevel) ??
        Constants.permissionLevelNone;
  }
}
