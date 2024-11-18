import 'package:flutter/material.dart';

import '../../../../common/services/storage.dart';

class VideoAnalyticsScreen extends StatelessWidget {
  const VideoAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Analytics'),
      ),
      body: FutureBuilder(
        // Using Future to get SharedPreferences data
        future: StorageService().init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> videosWithData =
                snapshot.data!.getAllVideosWithTimestamps();

            return ListView.builder(
              itemCount: videosWithData.length,
              itemBuilder: (context, index) {
                String videoId = videosWithData[index];
                Map<String, dynamic> stats =
                    snapshot.data!.getVideoStatistics(videoId);
                List<Map<String, dynamic>> timestamps = stats['timestamps'];

                // Group timestamps by watch session
                Map<String, List<String>> watchSessions = {};

                for (var entry in timestamps) {
                  String datetime = entry['datetime'];
                  String timestamp = entry['timestamp'];
                  String dateOnly = DateTime.parse(datetime)
                      .toLocal()
                      .toString()
                      .split(' ')[0];

                  watchSessions.putIfAbsent(dateOnly, () => []);
                  watchSessions[dateOnly]!.add(timestamp);
                }

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text('Video $videoId - course_video_id = $videoId'),
                    children: [
                      ...watchSessions.entries.map((session) {
                        int watchIndex =
                            watchSessions.keys.toList().indexOf(session.key) +
                                1;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Watch $watchIndex:',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            ...session.value.map((time) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  child: Text('Video paused at $time'),
                                )),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
