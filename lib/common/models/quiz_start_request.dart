class QuizStartRequestEntity {
  final int courseId;
  final int lessonId;
  final int courseVideoId;

  QuizStartRequestEntity({
    required this.courseId,
    required this.lessonId,
    required this.courseVideoId,
  });

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'lesson_id': lessonId,
      'course_video_id': courseVideoId,
    };
  }
}