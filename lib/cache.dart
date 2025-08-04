import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


Future saveToCache(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(value));
}

Future readCache(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);
  if (jsonString == null) return null;
  return jsonDecode(jsonString);
}

Future clearCache() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}