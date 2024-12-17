class QuizResultResponseEntity {
  int? code;
  String? msg;
  QuizResultResponseItem? data;

  QuizResultResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory QuizResultResponseEntity.fromJson(Map<String, dynamic> json) =>
      QuizResultResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : QuizResultResponseItem.fromJson(json["data"]),
      );
}

class QuizResultResponseItem{
  final String message;
  final Map<String, dynamic> quiz;  // Representing the quiz object, you can modify this to a specific structure if needed
  final int score;
  final bool completed;

  QuizResultResponseItem({
    required this.message,
    required this.quiz,
    required this.score,
    required this.completed,
  });

  factory QuizResultResponseItem.fromJson(Map<String, dynamic> json) => QuizResultResponseItem(
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