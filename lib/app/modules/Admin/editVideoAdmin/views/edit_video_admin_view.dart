import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_video_admin_controller.dart';

class EditVideoAdminView extends GetView<EditVideoAdminController> {
  const EditVideoAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditVideoAdminController controller =
        Get.put(EditVideoAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Videos'),
        centerTitle: true,
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
              return Card(
                child: ListTile(
                  title: Text(video['title']),
                  subtitle: Text(video['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editVideo(video);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteVideo(video.id);
                        },
                      ),
                    ],
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
      content: Column(
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
