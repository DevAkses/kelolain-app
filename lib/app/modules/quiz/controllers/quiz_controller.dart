import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/quiz/models/quiz_model.dart';

class QuizController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var quizList = <Quiz>[].obs;
  var questionList = <Question>[].obs;

  Stream<QuerySnapshot> getQuizList() {
    return firestore.collection('quiz').snapshots();
  }

  void updateQuizList(QuerySnapshot snapshot) {
    quizList.clear();
    quizList.addAll(snapshot.docs.map((doc) => Quiz.fromDocument(doc)).toList());
  }

  Stream<QuerySnapshot> getQuestionList(String quizId) {
    return firestore
        .collection('quiz')
        .doc(quizId)
        .collection('question')
        .snapshots();
  }

  void updateQuestionList(QuerySnapshot snapshot) {
    questionList.clear();
    questionList.addAll(snapshot.docs.map((doc) => Question.fromDocument(doc)).toList());
  }
}
