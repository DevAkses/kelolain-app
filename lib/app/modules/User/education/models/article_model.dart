import 'package:cloud_firestore/cloud_firestore.dart';

class Article{
  final String id;
  final String title;
  final String content;
  final String source;
  final DateTime postAt;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.source,
    required this.postAt,
  });

  factory Article.fromDocument(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Article(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      source: data['source'] ?? '',
      postAt: (data['postAt'] as Timestamp).toDate(),
    );
  }
}