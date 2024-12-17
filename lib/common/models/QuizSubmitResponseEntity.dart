class QuizSubmitResponseEntity {
  int? code;
  String? msg;
  QuizSubmitItem? data;

  QuizSubmitResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory QuizSubmitResponseEntity.fromJson(Map<String, dynamic> json) =>
      QuizSubmitResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data:
            json["data"] == null ? null : QuizSubmitItem.fromJson(json["data"]),
      );
}

class QuizSubmitItem {
  final int score;
  final bool completed;
  final DateTime quizEndedAt;

  QuizSubmitItem({
    required this.score,
    required this.completed,
    required this.quizEndedAt,
  });

  // Deserialize from JSON
  factory QuizSubmitItem.fromJson(Map<String, dynamic> json) {
    return QuizSubmitItem(
      score: json['score'],
      completed: json['completed'],
      quizEndedAt: DateTime.parse(json['quiz_ended_at']),
    );
  }
}
