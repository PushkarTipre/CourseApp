import 'package:course_app/common/utils/pop_messages.dart';
import 'package:course_app/pages/profile/editprofile/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/models/UserRequestEntity.dart';

class Edit_Profile_View extends ConsumerWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Update User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'New Username (Optional)'),
            ),
            TextField(
              controller: avatarController,
              decoration:
                  InputDecoration(labelText: 'New Avatar URL (Optional)'),
            ),
            TextField(
              controller: jobController,
              decoration: InputDecoration(labelText: 'New Job (Optional)'),
            ),
            TextField(
              controller: descriptionController,
              decoration:
                  InputDecoration(labelText: 'New Description (Optional)'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await ref.read(editProfileControllerProvider(
                    editProfile: UserRequestEntity(
                  username: usernameController.text.isNotEmpty
                      ? usernameController.text
                      : null,
                  avatar: avatarController.text.isNotEmpty
                      ? avatarController.text
                      : null,
                  job:
                      jobController.text.isNotEmpty ? jobController.text : null,
                  description: descriptionController.text.isNotEmpty
                      ? descriptionController.text
                      : null,
                )).future);

                toastInfo("User Updated: $result");
              },
              child: const Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
