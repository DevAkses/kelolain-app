import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingSession{
  final String id;
  final DateTime jadwal;
  final int durasi;
  final String tautanGmeet;
  final String konselorId;

  CounselingSession({
    required this.id,
    required this.jadwal,
    required this.durasi,
    required this.tautanGmeet,
    required this.konselorId
  });

  factory CounselingSession.fromDocument(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CounselingSession(
      id: doc.id,
      jadwal: (data['jadwal'] as Timestamp).toDate(),
      durasi: data['durasi'] ?? 0,
      tautanGmeet: data['tautanGmeet'] ?? '',
      konselorId: data['konselorId'] ?? '',
    );
  }
}