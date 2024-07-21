import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../editArticleAdmin/views/edit_article_admin_view.dart';
import '../../editChallengeAdmin/views/edit_challenge_admin_view.dart';
import '../../editQuizAdmin/views/list_quiz_admin_view.dart';
import '../../editVideoAdmin/views/edit_video_admin_view.dart';
import '../controllers/homepage_admin_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class HomepageAdminView extends GetView<HomepageAdminController> {
  const HomepageAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Homepage', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMenuItem(
              icon: Icons.article,
              label: 'Articles',
              onTap: () => Get.to(() => const EditArticleAdminView()),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.video_library,
              label: 'Videos',
              onTap: () => Get.to(() => const EditVideoAdminView()),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.quiz,
              label: 'Quizzes',
              onTap: () => Get.to(() => const ListQuizAdminView()),
            ),
            const SizedBox(height: 16),
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
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textHijauTua,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}