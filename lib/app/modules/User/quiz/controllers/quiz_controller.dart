import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/quiz/models/quiz_model.dart';

class QuizController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  var quizList = <Quiz>[].obs;
  var questionList = <Question>[].obs;
  var selectedAnswers = <String?>[].obs;
  var score = 0.obs;

  Stream<QuerySnapshot> getQuizList() {
    return firestore.collection('quiz').snapshots();
  }

  void updateQuizList(QuerySnapshot snapshot) {
    quizList.clear();
    quizList
        .addAll(snapshot.docs.map((doc) => Quiz.fromDocument(doc)).toList());
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
    questionList.addAll(
        snapshot.docs.map((doc) => Question.fromDocument(doc)).toList());
    selectedAnswers.assignAll(List<String?>.filled(questionList.length, null));
  }

  void selectAnswer(int index, String answer) {
    selectedAnswers[index] = answer;
    selectedAnswers.refresh();
  }

  Future<void> checkAnswer(String quizId) async {
    score.value = 0;
    for (int i = 0; i < questionList.length; i++) {
    
      if (selectedAnswers[i] == questionList[i].jawaban) {
        score.value += questionList[i].poin;
      }
    }

    await saveResult(quizId);
  }

  Future<void> saveResult(String quizId) async {
    await firestore.collection('quizResult').add({
      'finishAt': DateTime.now(),
      'quizId': quizId,
      'point': score.value,
      'userId': firebaseAuth.currentUser!.uid
    });
  }

  
}
