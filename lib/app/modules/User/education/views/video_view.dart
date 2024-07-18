import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/models/video_model.dart';

class VideoWidget extends GetView<EducationController> {
  const VideoWidget({super.key});

  Widget cardItem(Video video, VoidCallback onTap) {
    String previewContent = video.description.split(' ').take(10).join(' ');
    if (video.description.split(' ').length > 10) {
      previewContent += '...';
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Source: video.sumber",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        previewContent,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    video.link,
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 60,
                        color: Colors.grey[300],
                        child:
                            Icon(Icons.video_library, color: Colors.grey[500]),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${_getTimeAgo(video.postAt)}",
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime postTime) {
    Duration difference = DateTime.now().difference(postTime);
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  @override
  Widget build(BuildContext context) {
    final EducationController educationController =
        Get.put(EducationController());

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
              return cardItem(
                video,
                () {},
              );
            },
          );
        });
      },
    );
  }
}
