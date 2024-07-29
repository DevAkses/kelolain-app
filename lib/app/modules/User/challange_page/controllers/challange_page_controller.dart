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
    challengeList.addAll(
        snapshot.docs.map((doc) => Challenge.fromDocument(doc)).toList());
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
    if (_currentUser == null) {
      return;
    }

    try {
      DocumentReference userRef =
          firestore.collection('users').doc(_currentUser!.uid);

      // Check article challenges
      await _checkChallenges(userRef, 'article', 'readArticle');

      // Check video challenges
      await _checkChallenges(userRef, 'video', 'watchVideo');
    } catch (e) {
      print("Error in checkAndCompleteChallenges: $e");
    }
  }

  Future<void> _checkChallenges(DocumentReference userRef, String challengeType,
      String userCollectionName) async {
    QuerySnapshot challengesSnapshot = await firestore
        .collection('challenges')
        .where('category', isEqualTo: challengeType)
        .get();

    QuerySnapshot userItemsSnapshot =
        await userRef.collection(userCollectionName).get();
    int itemCount = userItemsSnapshot.docs.length;

    for (QueryDocumentSnapshot challenge in challengesSnapshot.docs) {
      int requiredCount = challenge['requiredCount'];
      int challengePoints = challenge['point'];
      String challengeId = challenge.id;

      if (itemCount >= requiredCount) {
        bool alreadyCompleted = await isChallengeCompletedByUser(challengeId);

        if (!alreadyCompleted) {
          await firestore
              .collection('challenges')
              .doc(challengeId)
              .collection('completedBy')
              .doc(_currentUser!.uid)
              .set({
            'completedAt': FieldValue.serverTimestamp(),
          });

          await firestore.runTransaction((transaction) async {
            DocumentSnapshot userSnapshot = await transaction.get(userRef);

            if (userSnapshot.exists) {
              Map<String, dynamic> userData =
                  userSnapshot.data() as Map<String, dynamic>;
              int currentPoints = userData['point'] ?? 0;
              int newPoints = currentPoints + challengePoints;

              transaction.update(userRef, {'point': newPoints});
            } else {
              print("User document does not exist");
            }
          });
        } else {
          print("Challenge $challengeId already completed");
        }
      } else {
        print(
            "Challenge $challengeId not met ($challengeType count: $itemCount, required: $requiredCount)");
      }
    }
  }
}
