import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DocIDService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getDocId() async {
    User? user = _auth.currentUser;
    if (user == null) return null;  // Check if the user is not logged in

    try {
      QuerySnapshot snapshot = await _firestore.collection('users')
                                  .where('email', isEqualTo: user.email)
                                  .limit(1)
                                  .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;  // Directly return the first document ID
      }
      return null;  // Return null if no document is found
    } catch (e) {
      print('Error fetching user document ID: $e');
      return null;  // Handle exceptions and return null on error
    }
  }
}
