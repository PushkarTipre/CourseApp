import 'package:course_app/common/models/quiz_attempt.dart';

class QuizStartResponseEntity {
  int? code;
  String? msg;
  QuizStartItem? data;

  QuizStartResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  QuizStartResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? QuizStartItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class QuizStartItem {
  final QuizAttempt? quiz; // No 'message' field in the response
  final String? quizUrl;
  final DateTime? quizStartedAt;
  final dynamic courseVideoId;

  QuizStartItem({
    this.quiz,
    this.quizUrl,
    this.quizStartedAt,
    this.courseVideoId,
  });

  QuizStartItem.fromJson(Map<String, dynamic> json)
      : quiz = json['quiz'] != null ? QuizAttempt.fromJson(json['quiz']) : null,
        quizUrl = json['quiz_url'],
        quizStartedAt = json['quiz_started_at'] != null
            ? DateTime.parse(json['quiz_started_at'])
            : null,
        courseVideoId = json['course_video_id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quiz != null) {
      data['quiz'] =
          quiz!.toJson(); // Ensure quiz is properly converted to JSON
    }
    data['quiz_url'] = quizUrl;
    data['quiz_started_at'] =
        quizStartedAt?.toIso8601String(); // Convert DateTime to string
    data['course_video_id'] = courseVideoId;
    return data;
  }
}
