import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question_admin_model.dart';
import '../models/quiz_admin_model.dart';

class QuizAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> tambahQuiz(Quiz quiz) async {
    try {
      await _firestore.collection('quiz').add({
        'createdAt': Timestamp.now(),
        'deskripsiQuiz': quiz.description,
        'titleQuiz': quiz.title,
      });
    } catch (e) {
      print('Error tambah quiz: $e');
      throw e;
    }
  }

  Future<void> tambahPertanyaan(String quizId, Question question) async {
    try {
      await _firestore
          .collection('quiz')
          .doc(quizId)
          .collection('question')
          .add({
            'pertanyaan': question.pertanyaan,
            'jawaban': question.jawaban,
            'opsiJawaban': question.opsiJawaban,
            'penjelasan': question.penjelasan,
            'point': question.point,
          });
    } catch (e) {
      print('Error tambah pertanyaan: $e');
      throw e;
    }
  }

  Future<void> tambahQuizDanPertanyaan(Quiz quiz, List<Question> questions) async {
    try {
      // Simpan quiz
      DocumentReference quizRef = await _firestore.collection('quiz').add({
        'createdAt': Timestamp.now(),
        'deskripsiQuiz': quiz.description,
        'titleQuiz': quiz.title,
      });

      // Simpan pertanyaan
      for (var question in questions) {
        await _firestore
            .collection('quiz')
            .doc(quizRef.id)
            .collection('question')
            .add({
              'pertanyaan': question.pertanyaan,
              'jawaban': question.jawaban,
              'opsiJawaban': question.opsiJawaban,
              'penjelasan': question.penjelasan,
              'point': question.point,
            });
      }
    } catch (e) {
      print('Error tambah quiz dan pertanyaan: $e');
      throw e;
    }
  }
}
