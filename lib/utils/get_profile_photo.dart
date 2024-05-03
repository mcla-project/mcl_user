// Import Flutter material package
import 'package:flutter/material.dart';
// Import Firebase storage package
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePhoto extends StatelessWidget {
  final String userId;

  const ProfilePhoto({Key? key, required this.userId}) : super(key: key);

  // Method to retrieve image URL from Firebase Storage
  Future<String> getUserProfileImageUrl(String userId) async {
    try {
      String imageUrl = await FirebaseStorage.instance
          .ref('users/$userId/profile.jpg')  // Assuming a standard path format
          .getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Failed to load user image: $e");
      return 'https://via.placeholder.com/150';  // Fallback image URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserProfileImageUrl(userId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(snapshot.data!),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else {
          // In case of errors or no data, fallback to a default image
          return const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          );
        }
      },
    );
  }
}
