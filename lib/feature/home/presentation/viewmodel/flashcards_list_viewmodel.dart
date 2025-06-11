import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/feature/auth/data/repositories/auth_repository.dart';
import 'package:pomodoro_app/feature/home/data/factories/flashcard_services_factory.dart';
import 'package:pomodoro_app/feature/home/domain/models/flashcard.dart';
import 'package:pomodoro_app/feature/home/domain/services/flashcard_services.dart';

class FlashcardsListViewModel extends GetxController {
  final FlashcardServices _service;
  final RxList<Flashcard> flashcards = <Flashcard>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Flashcard?> selectedFlashcard = Rx<Flashcard?>(null);
  final questionController = TextEditingController();
  final responseController = TextEditingController();
  final newQuestionController = TextEditingController();
  final newResponseController = TextEditingController();

  FlashcardsListViewModel(AuthRepository authRepository)
      : _service = FlashcardServicesFactory.create(authRepository);

  @override
  void onInit() {
    super.onInit();
    loadFlashcards();
  }

  @override
  void onClose() {
    questionController.dispose();
    responseController.dispose();
    newQuestionController.dispose();
    newResponseController.dispose();
    super.onClose();
  }

  Future<void> loadFlashcards() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final loadedFlashcards = await _service.getFlashcards();
      flashcards.value = loadedFlashcards;
    } catch (e) {
      errorMessage.value = e.toString();
      print('e.toString()');
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os flashcards: ${e.toString()}',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void startEditing(Flashcard flashcard) {
    selectedFlashcard.value = flashcard;
    questionController.text = flashcard.question;
    responseController.text = flashcard.response;
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xff336E6C),
        title: const Text(
          'Editar Flashcard',
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              style: const TextStyle(color: Color(0xffFFFFFF)),
              decoration: const InputDecoration(
                labelText: 'Pergunta',
                labelStyle: TextStyle(color: Color(0xffFFFFFF)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFFFFFF)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff73ECBF)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: responseController,
              style: const TextStyle(color: Color(0xffFFFFFF)),
              decoration: const InputDecoration(
                labelText: 'Resposta',
                labelStyle: TextStyle(color: Color(0xffFFFFFF)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFFFFFF)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff73ECBF)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              selectedFlashcard.value = null;
              questionController.clear();
              responseController.clear();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color(0xffFFFFFF)),
            ),
          ),
          ElevatedButton(
            onPressed: saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff73ECBF),
            ),
            child: const Text(
              'Salvar',
              style: TextStyle(
                color: Color(0xff336E6C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveChanges() async {
    if (selectedFlashcard.value == null) return;

    final updatedFlashcard = Flashcard(
      id: selectedFlashcard.value!.id,
      question: questionController.text,
      response: responseController.text,
    );

    try {
      await _service.updateFlashcard(updatedFlashcard);

      // Atualiza a lista local
      final index =
          flashcards.indexWhere((f) => f.id == updatedFlashcard.id);
      if (index != -1) {
        flashcards[index] = updatedFlashcard;
      }

      Get.back();
      selectedFlashcard.value = null;
      questionController.clear();
      responseController.clear();

      Get.snackbar(
        'Sucesso',
        'Flashcard atualizado com sucesso!',
        backgroundColor: const Color(0xff73ECBF),
        colorText: const Color(0xff336E6C),
      );
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Erro',
        'Não foi possível atualizar o flashcard: ${e.toString()}',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
    }
  }

  void showAddFlashcardDialog() {
    newQuestionController.clear();
    newResponseController.clear();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xff336E6C),
        title: const Text(
          'Novo Flashcard',
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newQuestionController,
              style: const TextStyle(color: Color(0xffFFFFFF)),
              decoration: const InputDecoration(
                labelText: 'Pergunta',
                labelStyle: TextStyle(color: Color(0xffFFFFFF)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFFFFFF)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff73ECBF)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newResponseController,
              style: const TextStyle(color: Color(0xffFFFFFF)),
              decoration: const InputDecoration(
                labelText: 'Resposta',
                labelStyle: TextStyle(color: Color(0xffFFFFFF)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFFFFFF)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff73ECBF)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              newQuestionController.clear();
              newResponseController.clear();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color(0xffFFFFFF)),
            ),
          ),
          ElevatedButton(
            onPressed: addNewFlashcard,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff73ECBF),
            ),
            child: const Text(
              'Adicionar',
              style: TextStyle(
                color: Color(0xff336E6C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addNewFlashcard() async {
    if (newQuestionController.text.isEmpty ||
        newResponseController.text.isEmpty) {
      Get.snackbar(
        'Erro',
        'Preencha todos os campos',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
      return;
    }

    try {
      final newFlashcard = Flashcard(
        id: '', // O ID será gerado pelo backend
        question: newQuestionController.text,
        response: newResponseController.text,
      );

      await _service.addFlashcard(newFlashcard);

      Get.back();
      newQuestionController.clear();
      newResponseController.clear();

      // Recarrega a lista de flashcards
      await loadFlashcards();

      Get.snackbar(
        'Sucesso',
        'Flashcard adicionado com sucesso!',
        backgroundColor: const Color(0xff73ECBF),
        colorText: const Color(0xff336E6C),
      );
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível adicionar o flashcard: ${e.toString()}',
        backgroundColor: const Color(0xffFF0000),
        colorText: const Color(0xffFFFFFF),
      );
    }
  }
}
