import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';

class ArticleWidget extends GetView<EducationController> {
  const ArticleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EducationController educationController = Get.put(EducationController());

    return StreamBuilder<QuerySnapshot>(
      stream: educationController.getArticleList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No articles found.'));
        }

        educationController.updateArticleList(snapshot.data!);

        return Obx(() {
          return ListView.builder(
            itemCount: educationController.articleList.length,
            itemBuilder: (context, index) {
              Article article = educationController.articleList[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Content: ${article.content}'),
                    Text('Source: ${article.source}'),
                    Text('Posted at: ${DateFormat.yMMMMd().add_jm().format(article.postAt)}'),
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
