import 'package:course_app/pages/lesson_detail/controller/lesson_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/watch_session_entity.dart';

class VideoAnalyticsScreen2 extends ConsumerWidget {
  final String courseId;
  final String videoId;
  final String videoTitle;

  const VideoAnalyticsScreen2({
    super.key,
    required this.courseId,
    required this.videoId,
    required this.videoTitle,
  });

  String _formatVideoTime(String timestamp) {
    // If the timestamp contains duration format (e.g., "1:23:45")
    if (timestamp.contains(':')) {
      final parts = timestamp.split(':');
      if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = int.parse(parts[2]);

        // If hours is 0, only show minutes:seconds
        if (hours == 0) {
          return '$minutes:${seconds.toString().padLeft(2, '0')}';
        }
        // If hours > 0, show full format
        return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      }
    }
    // Return original timestamp if it's not in the expected format
    return timestamp;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Analytics:${courseId.toString()}'),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ref
            .read(lessonDataControllerProvider.notifier)
            .analyticsService
            .generateAnalyticsReport(courseId.toString(), videoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          print('Connection State: ${snapshot.connectionState}');
          print('Has Error: ${snapshot.hasError}');
          if (snapshot.hasError) print('Error: ${snapshot.error}');
          print('Has Data: ${snapshot.hasData}');
          print('Data: ${snapshot.data}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Analytics Error: ${snapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading analytics: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Debug the report data
          final report = snapshot.data;
          print('Report: $report');

          if (report == null) {
            return const Center(
              child: Text('No data available'),
            );
          }
          final List<dynamic> rawSessions = report['detailedSessions'] ?? [];
          final List<WatchSession> sessions = rawSessions
              .map((session) =>
                  WatchSession.fromJson(session as Map<String, dynamic>))
              .toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVideoInfoCard(videoTitle),
                  SizedBox(height: 16),
                  _buildOverviewCard(report),
                  SizedBox(height: 16),
                  _buildPausePointsCard(report),
                  SizedBox(height: 16),
                  _buildSessionsCard(sessions),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoInfoCard(String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Video Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'CourseId: $courseId',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'ID: $videoId',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(Map<String, dynamic> report) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildStatRow(
              'Total Sessions',
              report['totalSessions'].toString(),
              Icons.schedule,
            ),
            SizedBox(height: 12),
            _buildStatRow(
              'Total Pauses',
              report['totalPauses'].toString(),
              Icons.pause_circle_outline,
            ),
            SizedBox(height: 12),
            _buildStatRow(
              'Average Duration',
              report['averageViewingDuration'],
              Icons.timer_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPausePointsCard(Map<String, dynamic> report) {
    final List<dynamic> rawPausePoints = report['commonPausePoints'] ?? [];
    final List<double> pausePoints =
        rawPausePoints.map((point) => (point as num).toDouble()).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Common Pause Points',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              pausePoints.isEmpty
                  ? 'No common pause points found'
                  : pausePoints
                      .map((point) => '${point.toStringAsFixed(1)}%')
                      .join(', '),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionsCard(List<WatchSession> sessions) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Viewing Sessions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];

                String startTime = session.startTime.contains(' ')
                    ? session.startTime.split(' ')[1]
                    : session.startTime;
                String endTime = session.endTime.contains(' ')
                    ? session.endTime.split(' ')[1]
                    : session.endTime;
                return ExpansionTile(
                  title: Text('Session ${index + 1} - ${session.date}'),
                  subtitle: Text(
                    '${_formatVideoTime(startTime)} - ${_formatVideoTime(endTime)}',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: session.pauseEvents.length,
                      itemBuilder: (context, eventIndex) {
                        final event = session.pauseEvents[eventIndex];
                        return ListTile(
                          dense: true,
                          title: Text(
                            'Paused at ${_formatVideoTime(event.duration)}', // Use event.duration instead of timestamp
                          ),
                          subtitle: Text(
                            'Progress: ${event.videoProgress.toStringAsFixed(1)}%',
                          ),
                          leading: Icon(Icons.pause, size: 20),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
