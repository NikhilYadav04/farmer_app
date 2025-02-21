import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //* to store auth status
  static Future<void> setAuthStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(dotenv.get('AUTH_TOKEN'), status);
  }

  //* to store user phone number
  static Future<void> setPhoneNumber(String PhoneNumber, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, PhoneNumber);
  }

  //* get user phone number
  static Future<String> getPhoneNumber(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "915250XXXX";
  }

  //* get profile complete status
  static Future<bool> getAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dotenv.get('AUTH_TOKEN')) ?? false;
  }
}
