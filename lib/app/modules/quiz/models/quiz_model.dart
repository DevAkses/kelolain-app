import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String id;
  final String titleQuiz;
  final String deskripsiQuiz;
  final DateTime createdAt;

  Quiz({
    required this.id,
    required this.titleQuiz,
    required this.deskripsiQuiz,
    required this.createdAt,
  });

  factory Quiz.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Quiz(
      id: doc.id,
      titleQuiz: data['titleQuiz'] ?? '',
      deskripsiQuiz: data['deskripsiQuiz'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

class Question {
  final String id;
  final String pertanyaan;
  final String jawaban;
  final Map<String, String> opsiJawaban;
  final String penjelasan;
  final int poin;

  Question({
    required this.id,
    required this.pertanyaan,
    required this.jawaban,
    required this.opsiJawaban,
    required this.penjelasan,
    required this.poin,
  });

  factory Question.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Question(
      id: doc.id,
      pertanyaan: data['pertanyaan'] ?? '',
      jawaban: data['jawaban'] ?? '',
      opsiJawaban: Map<String, String>.from(data['opsiJawaban'] ?? {}),
      penjelasan: data['penjelasan'] ?? '',
      poin: data['poin'] ?? 0,
    );
  }
}
