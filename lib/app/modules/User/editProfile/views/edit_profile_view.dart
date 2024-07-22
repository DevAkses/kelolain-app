import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: Utils.header),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildListTileTextField(
              icon: Icons.person,
              label: 'Nama Lengkap',
              controller: controller.fullNameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            _buildListTileTextField(
              icon: Icons.calendar_today,
              label: 'Umur',
              controller: controller.ageController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            _buildListTileTextField(
              icon: Icons.work,
              label: 'Pekerjaan',
              controller: controller.professionController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            ButtonWidget(onPressed: () => controller.saveProfile(), nama: "Simpan")
          ],
        ),
      ),
    );
  }

  Widget _buildListTileTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.withOpacity(0.1),
        child: Icon(icon, color: Colors.blue),
      ),
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}