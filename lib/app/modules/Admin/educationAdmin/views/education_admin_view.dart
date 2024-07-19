import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/education_admin_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class EducationAdminView extends GetView<EducationAdminController> {
  const EducationAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EducationAdminController controller = Get.put(EducationAdminController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Education Admin'),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Articles'),
              Tab(text: 'Videos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildArticlesTab(context),
            _buildVideosTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildTextField(controller.articleTitleC, 'Title'),
          _buildTextField(controller.articleContentC, 'Content'),
          _buildTextField(controller.articleSourceC, 'Source'),
          const SizedBox(height: 10),
          _buildImagePicker(),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.addArticle(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Add Article', style: TextStyle(color: AppColors.textPutih)),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildTextField(controller.videoTitleC, 'Title'),
          _buildTextField(controller.videoDescriptionC, 'Description'),
          _buildTextField(controller.videoLinkC, 'Link'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.addVideo(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Add Video', style: TextStyle(color: AppColors.textPutih)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.abuAbu),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.abuAbu),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Obx(() {
      return controller.articleImage.value != null
          ? Container(
              decoration: BoxDecoration(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(controller.articleImage.value!.path),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.abuAbu.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.abuAbu),
              ),
              child: Center(
                child: const Text('No image selected', style: TextStyle(color: AppColors.abuAbu)),
              ),
            );
    });
  }
}
