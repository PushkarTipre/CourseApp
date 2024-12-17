class QuizAttempt {
  final int? id;
  final int userId;
  final String userName;
  final String uniqueId;
  final int courseId;
  final int lessonId;
  final String courseVideoId;
  final int score;
  final bool completed;
  final DateTime attemptedAt;
  final DateTime quizStartedAt;

  QuizAttempt({
    this.id,
    required this.userId,
    required this.userName,
    required this.uniqueId,
    required this.courseId,
    required this.lessonId,
    required this.courseVideoId,
    required this.score,
    required this.completed,
    required this.attemptedAt,
    required this.quizStartedAt,
  });

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      uniqueId: json['unique_id'],
      courseId: json['course_id'],
      lessonId: json['lesson_id'],
      courseVideoId: json['course_video_id'].toString(),
      score: json['score'],
      completed: json['completed'],
      attemptedAt: json['attempted_at'] != null
          ? DateTime.parse(json['attempted_at'])
          : DateTime.now(), // Default to current date if null
      quizStartedAt: json['quiz_started_at'] != null
          ? DateTime.parse(json['quiz_started_at'])
          : DateTime.now(), // Default to current date if null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['unique_id'] = uniqueId;
    data['course_id'] = courseId;
    data['lesson_id'] = lessonId;
    data['course_video_id'] = courseVideoId;
    data['score'] = score;
    data['completed'] = completed;
    data['attempted_at'] = attemptedAt.toIso8601String();
    data['quiz_started_at'] = quizStartedAt.toIso8601String();
    return data;
  }
}
