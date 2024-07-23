import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';
import '../controllers/edit_article_admin_controller.dart';

class EditArticleAdminView extends GetView<EditArticleAdminController> {
  const EditArticleAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    EditArticleAdminController controller =
        Get.put(EditArticleAdminController());
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBackLeading(),
        title: const Text('Daftar Artikel', style: Utils.header),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: controller.getArticlesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No articles found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var article = snapshot.data!.docs[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 0.6, horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.backgroundCard,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      article['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      article['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _editArticle(article);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.deleteArticle(article.id);
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

  void _editArticle(DocumentSnapshot article) {
    TextEditingController titleController =
        TextEditingController(text: article['title']);
    TextEditingController contentController =
        TextEditingController(text: article['content']);
    TextEditingController sourceController =
        TextEditingController(text: article['source']);

    Get.defaultDialog(
      title: "Edit Article",
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
          TextField(
            controller: sourceController,
            decoration: const InputDecoration(labelText: 'Source'),
          ),
        ],
      ),
      textConfirm: "Save",
      onConfirm: () {
        controller.editArticle(article.id, {
          'title': titleController.text,
          'content': contentController.text,
          'source': sourceController.text,
        });
        Get.back();
      },
      textCancel: "Cancel",
    );
  }
}
