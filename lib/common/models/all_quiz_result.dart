class AllQuizResultResponseEntity {
  final int code;
  final String msg;
  final List<AllQuizResultData> data; // Changed to List<AllQuizResultData>

  AllQuizResultResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory AllQuizResultResponseEntity.fromJson(Map<String, dynamic> json) =>
      AllQuizResultResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: (json["data"] as List<dynamic>)
            .map((x) => AllQuizResultData.fromJson(x))
            .toList(),
      );
}

class AllQuizResultData {
  final String quiz_unique_id;
  final int score;
  final bool completed;
  final DateTime attempted_at;

  AllQuizResultData({
    required this.quiz_unique_id,
    required this.score,
    required this.completed,
    required this.attempted_at,
  });

  factory AllQuizResultData.fromJson(Map<String, dynamic> json) =>
      AllQuizResultData(
        quiz_unique_id: json["quiz_unique_id"],
        score: json["score"],
        completed: json["completed"],
        attempted_at: DateTime.parse(json["attempted_at"]),
      );
}
