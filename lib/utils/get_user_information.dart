import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class UserInfoWidget extends StatelessWidget {
  final Future<Map<String, dynamic>> Function() getDocData;
  final String fieldName;
  final Color color;

  const UserInfoWidget({
    super.key,
    required this.getDocData,
    required this.fieldName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getDocData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var fieldData = snapshot.data?[fieldName];
          if (fieldData == null) {
            return const Text('No data available');
          } else if (fieldData is String && _isImageUrl(fieldData)) {
            // Assume the field contains an image URL
            return CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(fieldData),
            );
          } else if (fieldData is Timestamp) {
            // Convert Timestamp to DateTime and format it
            DateTime date = fieldData.toDate();
            return Text(
              DateFormat('yyyy-MM-dd').format(date),
              style: TextStyle(color: color),
            );
          } else if (fieldData is String) {
            // Assume the field contains text
            return Text(
              fieldData,
              style: TextStyle(color: color),
            );
          } else {
            return Text(
              'Unsupported data type',
              style: TextStyle(color: color),
            );
          }
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  // Helper function to determine if a given string is likely a URL
  bool _isImageUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }
}
