import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';
import 'package:safeloan/app/modules/User/education/views/detail_article_page.dart';

class ArticleWidget extends GetView<EducationController> {
  const ArticleWidget({super.key});

  Widget cardItem(Article article, VoidCallback onTap) {
    String previewContent = article.content.split(' ').take(10).join(' ');
    if (article.content.split(' ').length > 10) {
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
              "Penulis: ${article.source}",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        previewContent,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://via.placeholder.com/60',
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: Icon(Icons.error, color: Colors.grey[500]),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "${_getTimeAgo(article.postAt)}",
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
            return cardItem(
              article,
              () {
                Get.to(DetailArticlePage(article: article));
              },
            );
          },
        );
      });
    },
  );
}

}
