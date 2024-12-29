class QuizResultResponseEntity {
  int? code;
  String? msg;
  QuizResultItem? data;

  QuizResultResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory QuizResultResponseEntity.fromJson(Map<String, dynamic> json) =>
      QuizResultResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data:
            json["data"] == null ? null : QuizResultItem.fromJson(json["data"]),
      );
}

class QuizResultItem {
  final String message;
  final Map<String, dynamic> quiz;
  final int score;
  final bool completed;

  QuizResultItem({
    required this.message,
    required this.quiz,
    required this.score,
    required this.completed,
  });

  factory QuizResultItem.fromJson(Map<String, dynamic> json) => QuizResultItem(
        message: json["message"],
        quiz: json["quiz"],
        score: json["score"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "quiz": quiz,
        "score": score,
        "completed": completed,
      };
}
