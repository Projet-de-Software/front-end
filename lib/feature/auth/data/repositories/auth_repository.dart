import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pomodoro_app/feature/auth/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = 'https://focusapp-i5j5.onrender.com';
  final _prefs = SharedPreferences.getInstance();

  Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    try {
      print('Enviando requisição para: $baseUrl/auth/login');
      print('Body: {"username": "$username", "password": "$password"}');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        return {
          'error': true,
          'message':
              'Erro na comunicação com o servidor: ${response.statusCode}',
        };
      }

      final data = jsonDecode(response.body);

      if (data['error'] == false) {
        final prefs = await _prefs;
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['data']));
      }

      return data;
    } catch (e, stackTrace) {
      print('Erro detalhado: $e');
      print('Stack trace: $stackTrace');
      return {
        'error': true,
        'message': 'Erro ao realizar login: $e',
      };
    }
  }

  Future<Map<String, dynamic>> signup(
      String username, String password) async {
    try {
      print('Enviando requisição para: $baseUrl/auth/register');
      print('Body: {"username": "$username", "password": "$password"}');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        return {
          'error': true,
          'message':
              'Erro na comunicação com o servidor: ${response.statusCode}',
        };
      }

      final data = jsonDecode(response.body);

      if (data['error'] == false) {
        final prefs = await _prefs;
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['data']));
      }

      return data;
    } catch (e, stackTrace) {
      print('Erro detalhado: $e');
      print('Stack trace: $stackTrace');
      return {
        'error': true,
        'message': 'Erro ao realizar cadastro: $e',
      };
    }
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove('token');
    await prefs.remove('user');
  }

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('token');
  }

  Future<UserModel?> getUser() async {
    final prefs = await _prefs;
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
