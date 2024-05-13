import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LocalStorage {
  Future<void> saveData(String key, String value);
  Future<String?> getData(String key);
  Future<void> updateData(String key, String value);
  Future<void> deleteData(String key);
}

class SharedPreferencesStorage implements LocalStorage {
  final String filePath = "D:\\Programing\\flutterLabs\\Lab4\\lab4\\Storage\\storage.txt";

  SharedPreferencesStorage();
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<void> saveData(String key, String value) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'key': key, 'value': value}),
    );
    // Handle response as needed
  }

  Future<String?> getData(String key) async {
    final response = await http.get(Uri.parse('$baseUrl/get?key=$key'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['value'];
    } else {
      return null;
    }
  }

  Future<void> updateData(String key, String value) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'key': key, 'value': value}),
    );
    // Handle response as needed
  }

  Future<void> deleteData(String key) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete?key=$key'));
    // Handle response as needed
  }
}
