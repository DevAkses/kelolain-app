import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';

import '../controllers/challenge_admin_controller.dart';

class ChallengeAdminView extends GetView<ChallengeAdminController> {
  const ChallengeAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    final ChallengeAdminController challengeAdminController = Get.put(ChallengeAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tantangan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(challengeAdminController.challengeTitleC, 1, 'Judul Tantangan'),
              _buildTextField(challengeAdminController.challengeDescriptionC, 5, 'Deskripsi Tantangan'),
              _buildTextField(challengeAdminController.challengePointC, 1, 'Poin'),
              const SizedBox(height: 10),
              _buildCategoryDropdown(challengeAdminController),
              const SizedBox(height: 40),
              ButtonWidget(
                onPressed: () {},
                nama: "Tambah Tantangan",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, int maxLines, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          labelStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Utils.backgroundCard),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Utils.biruDua),
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(ChallengeAdminController controller) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        value: controller.selectedCategory.value.isEmpty
            ? null
            : controller.selectedCategory.value,
        onChanged: controller.selectCategory,
        hint: const Text('Kategori'),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Utils.backgroundCard),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Utils.biruDua),
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        ),
        items: controller.categories.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
      );
    });
  }
}
