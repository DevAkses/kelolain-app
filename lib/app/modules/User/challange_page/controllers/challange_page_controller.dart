import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/challange_page/models/challange_model.dart';

class ChallangePageController extends GetxController {
  late User? _currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var challengeList = <Challenge>[].obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> listChallenge() {
    return firestore.collection('challenges').snapshots();
  }

  void updateChallengeList(QuerySnapshot snapshot) {
    challengeList.clear();
    challengeList
        .addAll(snapshot.docs.map((doc) => Challenge.fromDocument(doc)).toList());
  }

  Future<bool> isChallengeCompletedByUser(String challengeId) async {
    if (_currentUser == null) return false;

    DocumentReference userRef = firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('completedBy')
        .doc(_currentUser!.uid);

    DocumentSnapshot userSnapshot = await userRef.get();
    return userSnapshot.exists;
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
      DocumentReference challengeRef =
          firestore.collection('challenges').doc(challenge.id);

      if (readArticlesCount >= requiredCount) {
        await challengeRef
            .collection('completedBy')
            .doc(_currentUser!.uid)
            .set({
          'completedAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }
}
