class QuizSubmitRequestEntity {
  final String quiz_unique_id;
  final int score;

  QuizSubmitRequestEntity({
    required this.quiz_unique_id,
    required this.score,
  });

  // Convert the object to a JSON map to send in the request
  Map<String, dynamic> toJson() {
    return {
      'quiz_unique_id': quiz_unique_id,
      'score': score,
    };
  }

  // Create an instance from JSON response
  factory QuizSubmitRequestEntity.fromJson(Map<String, dynamic> json) {
    return QuizSubmitRequestEntity(
      quiz_unique_id: json['quiz_unique_id'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}
