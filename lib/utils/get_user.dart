// user_data_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  final user = FirebaseAuth.instance.currentUser!;
  Future<Map<String, dynamic>> getDocData() async {
    Map<String, dynamic> userData = {};
    await FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      for (var element in snapshot.docs) {
        if (element['email'] == user.email) {
          // docIDS.add(element.id);
          userData = element.data();
        }
      }
    });
    return userData;
  }
}