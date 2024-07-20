import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChallangePageController extends GetxController {
  late User? _currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listChallenge() {
    return firestore.collection('challenges').snapshots();
  }

  @override
  void onInit() {
    _currentUser = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  Future<void> checkAndCompleteChallenges() async {
    if (_currentUser == null) return;

    DocumentReference userRef =
        firestore.collection('users').doc(_currentUser!.uid);

    QuerySnapshot challengesSnapshot = await firestore
        .collection('challenges')
        .where('category', isEqualTo: 'article')
        .get();

    List<QueryDocumentSnapshot> challenges = challengesSnapshot.docs;

    QuerySnapshot readArticlesSnapshot =
        await userRef.collection('readArticle').get();
    int readArticlesCount = readArticlesSnapshot.docs.length;

    for (QueryDocumentSnapshot challenge in challenges) {
      int requiredCount = challenge['requiredCount'];
      int challengePoints = challenge['points'];
      DocumentReference challengeRef =
          firestore.collection('challenges').doc(challenge.id);

      if (readArticlesCount >= requiredCount) {
        await challengeRef
            .collection('completedBy')
            .doc(_currentUser!.uid)
            .set({
          'completedAt': FieldValue.serverTimestamp(),
        });
        await firestore.runTransaction((transaction) async {
          DocumentSnapshot userDoc = await transaction.get(userRef);
          if (!userDoc.exists) return;

          int currentPoints = userDoc.get('points') ?? 0;
          int updatedPoints = currentPoints + challengePoints;

          transaction.update(userRef, {'points': updatedPoints});
        });
      }
    }
  }
}
