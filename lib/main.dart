import 'package:flutter/material.dart';
import 'package:mcl_user/components/user_info.dart';
import 'components/base_layout.dart';
import 'pages/profile_page/view_card.dart'; // Import the base layout

void main() {

  runApp(MyApp(
    home: ViewCardPage(
      userInfo: UserInfo(
        name: 'Merlin',
        username: 'merlin123',
        schoolOffice: 'PLM School',
        address: '123 Main Street',
        contactNumber: '555-1234',
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required home});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: const Color(0xFF013822),
      ),
      title: 'Manila City Library',
      home: const BaseLayout(),
    );
  }
}
