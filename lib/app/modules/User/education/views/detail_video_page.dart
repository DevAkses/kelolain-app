import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/models/video_model.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends GetView<EducationController> {
  final Video video;

  const YouTubePlayerScreen({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final youtubeController = controller.youtubeController.value;
      if (youtubeController == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          controller.isFullScreen.value = false;
        },
        onEnterFullScreen: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          controller.isFullScreen.value = true;
        },
        player: YoutubePlayer(
          controller: youtubeController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                youtubeController.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                print('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            print('Player is ready.');
          },
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(backgroundColor: AppColors.primaryColor, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPutih,), onPressed: (){Get.back();},),),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: controller.isFullScreen.value
                      ? MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height
                      : 16 / 9, // Adjust aspect ratio as needed
                  child: player,
                ),
                if (!controller.isFullScreen.value)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
                        ),
                        const SizedBox(height: 8),
                        Text('Posted: ${video.postAt.toString()}'),
                        // Add other video details here
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      );
    });
  }
}
