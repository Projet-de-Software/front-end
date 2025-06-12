import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/domain/models/task.dart';
import 'package:pomodoro_app/feature/home/domain/services/task_services.dart';

class TaskApiServices implements TaskServices {
  final String baseUrl = 'https://focusapp-i5j5.onrender.com';
  final AuthRepository _authRepository;

  TaskApiServices(this._authRepository);

  @override
  Future<List<Task>> getTasks() async {
    try {
      final token = await _authRepository.getToken();
      final userId = await _authRepository.getUserId();

      if (token == null || userId == null) {
        throw Exception('Token ou ID do usuário não encontrado');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/getAllTasksByIdUser/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['error'] == true) {
          throw Exception(
              jsonResponse['message'] ?? 'Erro ao buscar tarefas');
        }

        final List<dynamic> data = jsonResponse['data'] ?? [];
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar tarefas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar tarefas: $e');
      throw Exception('Erro ao buscar tarefas: $e');
    }
  }

  @override
  Future<void> addTask(Task task) async {
    try {
      final token = await _authRepository.getToken();
      final userId = await _authRepository.getUserId();

      if (token == null || userId == null) {
        throw Exception('Token ou ID do usuário não encontrado');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/task/register/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': task.title,
          'description': task.description,
          'date': task.date.toIso8601String(),
          'userId': userId,
        }),
      );

      if (response.statusCode != 200) {
        final jsonResponse = json.decode(response.body);
        throw Exception(jsonResponse['message'] ??
            'Erro ao adicionar tarefa: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao adicionar tarefa: $e');
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      final token = await _authRepository.getToken();
      final userId = await _authRepository.getUserId();

      if (token == null || userId == null) {
        throw Exception('Token ou ID do usuário não encontrado');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/task/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': task.id,
          'title': task.title,
          'description': task.description,
          'date': task.date.toIso8601String(),
          'userId': userId,
        }),
      );

      if (response.statusCode != 200) {
        final jsonResponse = json.decode(response.body);
        throw Exception(jsonResponse['message'] ??
            'Erro ao atualizar tarefa: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar tarefa: $e');
    }
  }
}
