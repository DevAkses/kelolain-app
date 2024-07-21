import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/edit_video_admin_controller.dart';

class EditVideoAdminView extends GetView<EditVideoAdminController> {
  const EditVideoAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditVideoAdminController controller =
        Get.put(EditVideoAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Videos', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: ()=> Get.back(),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: StreamBuilder(
        stream: controller.getVideosStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No videos found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var video = snapshot.data!.docs[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 0.6, horizontal: 5),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card.outlined(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      video['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(video['description'], maxLines: 2, overflow: TextOverflow.ellipsis,),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _editVideo(video);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.deleteVideo(video.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _editVideo(DocumentSnapshot video) {
    TextEditingController titleController =
        TextEditingController(text: video['title']);
    TextEditingController descriptionController =
        TextEditingController(text: video['description']);
    TextEditingController linkController =
        TextEditingController(text: video['link']);

    Get.defaultDialog(
      title: "Edit Video",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(labelText: 'Link'),
            ),
          ],
        ),
      ),
      textConfirm: "Save",
      onConfirm: () {
        controller.editVideo(video.id, {
          'title': titleController.text,
          'description': descriptionController.text,
          'link': linkController.text,
        });
        Get.back();
      },
      textCancel: "Cancel",
    );
  }
}
