class Flashcard {
  final String id;
  final String question;
  final String response;

  Flashcard({
    required this.id,
    required this.question,
    required this.response,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'] as String,
      question: json['question'] as String,
      response: json['response'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'question': question, 'response': response};
  }
}
