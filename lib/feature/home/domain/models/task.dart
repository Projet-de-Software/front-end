class Task {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  // Métodos fromJson e toJson seriam adicionados aqui para integração com backend
  // factory Task.fromJson(Map<String, dynamic> json) { ... }
  // Map<String, dynamic> toJson() { ... }
}
