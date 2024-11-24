import 'package:course_app/common/models/pause_event_entity.dart';

class WatchSession {
  final String date;
  final String startTime;
  final String endTime;
  final List<PauseEvent> pauseEvents;

  WatchSession({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.pauseEvents,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'pauseEvents': pauseEvents.map((event) => event.toJson()).toList(),
      };

  factory WatchSession.fromJson(Map<String, dynamic> json) => WatchSession(
        date: json['date'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        pauseEvents: (json['pauseEvents'] as List)
            .map((event) => PauseEvent.fromJson(event))
            .toList(),
      );
}
