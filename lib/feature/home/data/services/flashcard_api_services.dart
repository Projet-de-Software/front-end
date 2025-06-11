import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';
import 'package:pomodoro_app/feature/home/domain/services/flashcard_services.dart';

class FlashcardApiServices implements FlashcardServices {
  final String baseUrl = 'https://focusapp-i5j5.onrender.com';
  final AuthRepository _authRepository;

  FlashcardApiServices(this._authRepository);

  @override
  Future<List<Flashcard>> getFlashcards() async {
    try {
      final token = await _authRepository.getToken();
      final userId = await _authRepository.getUserId();

      if (token == null || userId == null) {
        throw Exception('Token ou ID do usuário não encontrado');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/getAllFlashCardsByIdUser/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['error'] == true) {
          throw Exception(jsonResponse['message']);
        }

        final List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Flashcard.fromJson(json)).toList();
      } else {
        throw Exception(
            'Erro ao carregar flashcards: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar flashcards: $e');
    }
  }

  @override
  Future<Flashcard> getFlashcardById(String id) async {
    try {
      final token = await _authRepository.getToken();

      if (token == null) {
        throw Exception('Token não encontrado');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/flashcards/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Flashcard.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Erro ao carregar flashcard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar flashcard: $e');
    }
  }

  @override
  Future<void> addFlashcard(Flashcard flashcard) async {
    try {
      final token = await _authRepository.getToken();
      final userId = await _authRepository.getUserId();

      if (token == null || userId == null) {
        throw Exception('Token ou ID do usuário não encontrado');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/flashcard/register/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'question': flashcard.question,
          'response': flashcard.response,
        }),
      );

      if (response.statusCode != 200) {
        final jsonResponse = json.decode(response.body);
        throw Exception(jsonResponse['message'] ??
            'Erro ao adicionar flashcard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao adicionar flashcard: $e');
    }
  }

  @override
  Future<void> updateFlashcard(Flashcard flashcard) async {
    try {
      final token = await _authRepository.getToken();

      if (token == null) {
        throw Exception('Token não encontrado');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/flashcard/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(flashcard.toJson()),
      );

      if (response.statusCode != 200) {
        final jsonResponse = json.decode(response.body);
        throw Exception(jsonResponse['message'] ??
            'Erro ao atualizar flashcard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar flashcard: $e');
    }
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    try {
      final token = await _authRepository.getToken();

      if (token == null) {
        throw Exception('Token não encontrado');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/flashcards/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Erro ao deletar flashcard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao deletar flashcard: $e');
    }
  }
}
