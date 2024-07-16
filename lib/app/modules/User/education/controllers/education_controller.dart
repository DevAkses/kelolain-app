import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';
import 'package:safeloan/app/modules/User/education/models/video_model.dart';

class EducationController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var articleList = <Article>[].obs;
  var videoList = <Video>[].obs;
  String educationDocumentId = 'q02NZjM7bwuOI9RDM226';

  Stream<QuerySnapshot> getArticleList() {
    return firestore
        .collection('educations')
        .doc(educationDocumentId)
        .collection('articles')
        .snapshots();
  }

  void updateArticleList(QuerySnapshot snapshot) {
    articleList.clear();
    articleList
        .addAll(snapshot.docs.map((doc) => Article.fromDocument(doc)).toList());
  }

  Stream<QuerySnapshot> getVideoList() {
    return firestore
        .collection('educations')
        .doc(educationDocumentId)
        .collection('videos')
        .snapshots();
  }

  void updateVideoList(QuerySnapshot snapshot) {
    videoList.clear();
    videoList
        .addAll(snapshot.docs.map((doc) => Video.fromDocument(doc)).toList());
  }
}
