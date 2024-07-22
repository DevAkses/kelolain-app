import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/education_admin_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class EducationAdminView extends GetView<EducationAdminController> {
  const EducationAdminView({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edukasi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Colors.green,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: "Membuat Artikel"),
                    Tab(text: "Menambah Video"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildArticlesTab(context),
                  _buildVideosTab(context),
                ],
              ),
            ),
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
          _buildTextField(controller.articleTitleC, 'Title'),
          _buildTextField(controller.articleContentC, 'Content'),
          _buildTextField(controller.articleSourceC, 'Source'),
          const SizedBox(height: 10),
          SizedBox(
            child: ElevatedButton(
              onPressed: () => controller.pickImage(),
              child: Text('Select Image'),
            ),
          ),
          const SizedBox(height: 10),

          _buildImagePicker(),
          const Spacer(),
          ButtonWidget(
              onPressed: () {
                controller.addArticle();
              },
              nama: "Tambah Artikel")
        ],
      ),
    );
  }

  Widget _buildVideosTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField(controller.videoTitleC, 'Title'),
          _buildTextField(controller.videoDescriptionC, 'Description'),
          _buildTextField(controller.videoLinkC, 'Link'),
          _buildTextField(controller.videoLinkC, 'Source'),
          const Spacer(),
          ButtonWidget(
              onPressed: () {
                controller.addVideo();
              },
              nama: "Tambah Video")
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
    return Stack(
      children: [
        controller.articleImage.value != null
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
              ),
        Positioned(
          bottom: 8,
          right: 8,
          child: ElevatedButton(
            onPressed: () => controller.pickImage(),
            child: const Text('Pick Image'),
          ),
        ),
      ],
    );
  });
}

}
