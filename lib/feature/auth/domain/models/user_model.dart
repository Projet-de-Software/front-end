class UserModel {
  final String id;
  final String username;
  final List<FlashCardModel> flashCardModels;
  final List<TaskModel> taskModels;
  final bool enabled;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  final List<String> authorities;

  UserModel({
    required this.id,
    required this.username,
    required this.flashCardModels,
    required this.taskModels,
    required this.enabled,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.authorities,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      flashCardModels: (json['flashCardModels'] as List)
          .map((e) => FlashCardModel.fromJson(e))
          .toList(),
      taskModels: (json['taskModels'] as List)
          .map((e) => TaskModel.fromJson(e))
          .toList(),
      enabled: json['enabled'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
      authorities: List<String>.from(json['authorities']),
    );
  }
}

class FlashCardModel {
  final String id;
  final String question;
  final String response;

  FlashCardModel({
    required this.id,
    required this.question,
    required this.response,
  });

  factory FlashCardModel.fromJson(Map<String, dynamic> json) {
    return FlashCardModel(
      id: json['id'],
      question: json['question'],
      response: json['response'],
    );
  }
}

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
