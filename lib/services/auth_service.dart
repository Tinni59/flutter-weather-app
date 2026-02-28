import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthService {
  static Future<void> register(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final hash = sha256.convert(utf8.encode(password)).toString();
    await prefs.setString(login, hash);
  }

  static Future<bool> login(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(login);
    if (stored == null) return false;

    final hash = sha256.convert(utf8.encode(password)).toString();
    return stored == hash;
  }
}
