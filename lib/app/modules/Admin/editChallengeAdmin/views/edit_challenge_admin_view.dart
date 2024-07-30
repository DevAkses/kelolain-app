import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/edit_challenge_admin_controller.dart';

class EditChallengeAdminView extends GetView<EditChallengeAdminController> {
  const EditChallengeAdminView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final EditChallengeAdminController editChallengeAdminController = Get.put(EditChallengeAdminController());
    final String challengeId = Get.parameters['id'] ?? '';

    if (challengeId.isNotEmpty) {
      editChallengeAdminController.fetchChallengeData(challengeId);
    }

    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBackLeading(),
        title: const Text('Edit Tantangan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(editChallengeAdminController.challengeTitleC, 'Judul'),
              _buildTextField(editChallengeAdminController.challengeSubTitleC, 'Sub Judul'),
              _buildTextField(editChallengeAdminController.challengeDescriptionC, 'Deskripsi Tantangan'),
              _buildTextField(editChallengeAdminController.challengePointC, 'Poin'),
              _buildTextField(editChallengeAdminController.challengeTargetC, 'Target'),
              const SizedBox(height: 40),
              ButtonWidget(
                onPressed: () {
                  if (challengeId.isNotEmpty) {
                    editChallengeAdminController.updateChallenge(challengeId).then((_) {
                      Get.back();
                      Get.snackbar('Success', 'Challenge updated successfully');
                    }).catchError((e) {
                      Get.snackbar('Error', 'Failed to update challenge');
                    });
                  }
                },
                nama: "Simpan",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
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
        maxLines: null, // Makes the TextFormField expand vertically based on content
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
