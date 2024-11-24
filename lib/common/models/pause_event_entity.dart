class PauseEvent {
  final String timestamp;
  final String duration;
  final double videoProgress;

  PauseEvent({
    required this.timestamp,
    required this.duration,
    required this.videoProgress,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'duration': duration,
        'videoProgress': videoProgress,
      };

  factory PauseEvent.fromJson(Map<String, dynamic> json) => PauseEvent(
        timestamp: json['timestamp'],
        duration: json['duration'],
        videoProgress: json['videoProgress'],
      );
}
