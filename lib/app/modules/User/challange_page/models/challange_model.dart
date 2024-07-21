import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  final String id;
  final String title;
  final String description;
  final int point;
  final int requiredCount;
  final String category;
  final DateTime createdAt;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.point,
    required this.requiredCount,
    required this.category,
    required this.createdAt,
  });

  factory Challenge.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Challenge(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      point: data['point'],
      requiredCount: data['requiredCount'],
      category: data['category'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

class CompletedBy {
  final String userId;
  final DateTime completedAt;

  CompletedBy({
    required this.userId,
    required this.completedAt,
  });

  factory CompletedBy.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CompletedBy(
      userId: doc.id,
      completedAt: (data['completedAt'] as Timestamp).toDate(),
    );
  }
}