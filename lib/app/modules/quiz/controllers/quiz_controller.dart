import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/quiz/models/quiz_model.dart';

class QuizController extends GetxController {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var quizList = <Quiz>[].obs;
}
