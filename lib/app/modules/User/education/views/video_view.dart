import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/models/video_model.dart';

class VideoWidget extends GetView<EducationController> {
  const VideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EducationController educationController = Get.put(EducationController());

    return StreamBuilder<QuerySnapshot>(
      stream: educationController.getVideoList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No videos found.'));
        }

        educationController.updateVideoList(snapshot.data!);

        return Obx(() {
          return ListView.builder(
            itemCount: educationController.videoList.length,
            itemBuilder: (context, index) {
              Video video = educationController.videoList[index];
              return ListTile(
                title: Text(video.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Link: ${video.link}'),
                    Text('Description: ${video.description}'),
                    Text('Posted at: ${DateFormat.yMMMMd().add_jm().format(video.postAt)}'),
                  ],
                ),
                onTap: () {
                  // Handle tap
                },
              );
            },
          );
        });
      },
    );
  }
}
