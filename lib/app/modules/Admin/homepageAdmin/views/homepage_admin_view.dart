import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../editArticleAdmin/views/edit_article_admin_view.dart';
import '../../editChallengeAdmin/views/edit_challenge_admin_view.dart';
import '../../editQuizAdmin/views/edit_quiz_admin_view.dart';
import '../../editVideoAdmin/views/edit_video_admin_view.dart';
import '../controllers/homepage_admin_controller.dart';

class HomepageAdminView extends GetView<HomepageAdminController> {
  const HomepageAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Homepage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.article),
              label: const Text('Articles'),
              onPressed: () {
                Get.to(() => const EditArticleAdminView());
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.video_library),
              label: const Text('Videos'),
              onPressed: () {
                Get.to(() => const EditVideoAdminView());
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.quiz),
              label: const Text('Quizzes'),
              onPressed: () {
                Get.to(() => const EditQuizAdminView());
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.flag),
              label: const Text('Challenges'),
              onPressed: () {
                Get.to(() => const EditChallengeAdminView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
