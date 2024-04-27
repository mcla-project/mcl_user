// user_name_widget.dart
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final Future<Map<String, dynamic>> Function() getDocData;
  final String fieldName;

  const UserInfoWidget(
      {super.key, required this.getDocData, required this.fieldName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getDocData(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('${snapshot.data?[fieldName]}',
                style: const TextStyle(fontSize: 16, color: Colors.white));
          }
        }
      },
    );
  }
}
