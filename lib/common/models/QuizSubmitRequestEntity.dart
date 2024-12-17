class QuizSubmitRequestEntity {
  final String uniqueId; // The unique identifier for the quiz attempt
  final int score; // The score the user achieved

  QuizSubmitRequestEntity({
    required this.uniqueId,
    required this.score,
  });

  // Convert the object to a JSON map to send in the request
  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'score': score,
    };
  }

  // Create an instance from JSON response
  factory QuizSubmitRequestEntity.fromJson(Map<String, dynamic> json) {
    return QuizSubmitRequestEntity(
      uniqueId: json['unique_id'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}
