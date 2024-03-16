import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserFavorite(String userId, String dormId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('favorites').doc(dormId).set({
        'isFavorite': true,
      });
    } catch (e) {
      print('Error adding user favorite: $e');
      throw e;
    }
  }

  Future<void> removeUserFavorite(String userId, String dormId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('favorites').doc(dormId).delete();
    } catch (e) {
      print('Error removing user favorite: $e');
      throw e;
    }
  }
}