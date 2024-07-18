import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/education_admin_controller.dart';

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
      child: Column(
        children: [
          TextField(
            controller: controller.articleTitleC,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: controller.articleContentC,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
          TextField(
            controller: controller.articleSourceC,
            decoration: const InputDecoration(labelText: 'Source'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.pickImage(),
            child: const Text('Upload Image'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.addArticle(),
            child: const Text('Add Article'),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller.videoTitleC,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: controller.videoDescriptionC,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: controller.videoLinkC,
            decoration: const InputDecoration(labelText: 'Link'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.addVideo(),
            child: const Text('Add Video'),
          ),
        ],
      ),
    );
  }
}
