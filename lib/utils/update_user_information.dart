// user_info_widget.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserInfo extends StatelessWidget {
  final Color color;

  const UpdateUserInfo({Key? key, required this.color}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection('users')
            .doc('docID') // replace 'docID' with the ID of the document to update
            .update({
          'field': 'new value', // replace 'field' with the field to update and 'new value' with the new value
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated')),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: $error')),
          );
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: const Text(
        'Update User Data',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}