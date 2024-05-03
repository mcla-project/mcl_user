import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DocIDService {
  final user = FirebaseAuth.instance.currentUser!;

  Future<String> getDocId() async {
    String docId = '';
    await FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      for (var element in snapshot.docs) {
        if (element['email'] == user.email) {
          docId = element.id;
          break;
        }
      }
    });
    return docId;
  }
}