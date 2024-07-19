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
          // Gambar Artikel
          article.image.isNotEmpty
              ? Image.network(
                  article.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: Icon(Icons.error, color: Colors.grey[500]),
                    );
                  },
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, color: Colors.grey[500]),
                ),
          // Judul Artikel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Sumber Artikel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Sumber: ${article.source}",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.abuAbu,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Konten Artikel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article.content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
