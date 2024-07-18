import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_challenge_admin_controller.dart';

class EditChallengeAdminView extends GetView<EditChallengeAdminController> {
  const EditChallengeAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditChallengeAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditChallengeAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
