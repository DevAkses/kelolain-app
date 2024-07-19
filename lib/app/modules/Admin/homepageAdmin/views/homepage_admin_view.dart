import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../editArticleAdmin/views/edit_article_admin_view.dart';
import '../../editChallengeAdmin/views/edit_challenge_admin_view.dart';
import '../../editQuizAdmin/views/edit_quiz_admin_view.dart';
import '../../editVideoAdmin/views/edit_video_admin_view.dart';
import '../controllers/homepage_admin_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class HomepageAdminView extends GetView<HomepageAdminController> {
  const HomepageAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Homepage'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          children: [
            _buildMenuItem(
              icon: Icons.article,
              label: 'Articles',
              onTap: () => Get.to(() => const EditArticleAdminView()),
            ),
            _buildMenuItem(
              icon: Icons.video_library,
              label: 'Videos',
              onTap: () => Get.to(() => const EditVideoAdminView()),
            ),
            _buildMenuItem(
              icon: Icons.quiz,
              label: 'Quizzes',
              onTap: () => Get.to(() => const EditQuizAdminView()),
            ),
            _buildMenuItem(
              icon: Icons.flag,
              label: 'Challenges',
              onTap: () => Get.to(() => const EditChallengeAdminView()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.textPutih,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textHijauTua,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
