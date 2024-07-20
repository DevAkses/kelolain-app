import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class DetailArticlePage extends StatefulWidget {
  final Article article;
  const DetailArticlePage({super.key, required this.article});

  @override
  _DetailArticlePageState createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  Timer? _timer;
  bool _hasMarkedAsRead = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 10), () async {
      if (!_hasMarkedAsRead) {
        final educationController = Get.find<EducationController>();
        final userId = FirebaseAuth.instance.currentUser!.uid;
        await educationController.markArticleAsRead(widget.article.id, userId);
        setState(() {
          _hasMarkedAsRead = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
            child: Text(widget.article.title,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 20.0),
            child: Text("Sumber : ${widget.article.source}",
                style: const TextStyle(fontSize: 12, color: AppColors.abuAbu)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.article.content,
            ),
          ),
        ],
      ),
    );
  }
}
