import 'package:flutter/material.dart';
import 'get_user.dart'; // Import the FirestoreService class

class GetUserInformation extends StatelessWidget {
  final String documentId;
  final FirestoreService _firestoreService = FirestoreService();
  final Function(Map<String, dynamic>) onUserDataFetched;

  GetUserInformation({required this.documentId, required this.onUserDataFetched});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _firestoreService.getUserData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          onUserDataFetched(snapshot.data!);
          return Column(children: <Widget>[
            Text('First Name: ${snapshot.data?['first_name']}'),
            // Text('Last Name: ${snapshot.data?['last_name']}'),
          ]);
        }
      },
    );
  }
}

