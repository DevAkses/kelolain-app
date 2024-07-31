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
  var quizResult = {}.obs; // Observable map to store quiz result

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
    questionList.addAll(
        snapshot.docs.map((doc) => Question.fromDocument(doc)).toList());
    selectedAnswers.assignAll(List<String?>.filled(questionList.length, null));
  }

  void selectAnswer(int index, String answer) {
    selectedAnswers[index] = answer;
    selectedAnswers.refresh();
  }

  Future<void> checkAnswer(String quizId) async {
    print('checkAnswer called');
    score.value = 0;
    for (int i = 0; i < questionList.length; i++) {
      print('Question: ${questionList[i].pertanyaan}');
      print('Selected Answer: ${selectedAnswers[i]}');
      print('Correct Answer: ${questionList[i].jawaban}');
      print('Point: ${questionList[i].poin}');

      if (selectedAnswers[i] == questionList[i].jawaban) {
        score.value += questionList[i].poin;
      }
    }

    print('Total Score: ${score.value}');
    await saveResult(quizId);
  }

  Future<void> saveResult(String quizId) async {
    await firestore.collection('quizResult').add({
      'finishAt': DateTime.now(),
      'quizId': quizId,
      'point': score.value,
      'userId': firebaseAuth.currentUser!.uid
    });
    print('Result saved');
    fetchQuizResult(quizId);
  }

  void fetchQuizResult(String quizId) async {
    // Assuming you want to fetch the latest result for the given quizId and userId
    final resultSnapshot = await firestore
        .collection('quizResult')
        .where('quizId', isEqualTo: quizId)
        .where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
        .orderBy('finishAt', descending: true)
        .limit(1)
        .get();

    if (resultSnapshot.docs.isNotEmpty) {
      quizResult.value = resultSnapshot.docs.first.data();
    }
  }
}
