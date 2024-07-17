import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class DetailArticlePage extends StatelessWidget {
  final Article article;
  const DetailArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPutih,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          Image.asset(
            'name',
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(article.title,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 20.0),
            child: Text("Sumber : ${article.source}",
                style: const TextStyle(fontSize: 12, color: AppColors.abuAbu)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              article.content,
            ),
          ),
        ],
      ),
    );
  }
}
