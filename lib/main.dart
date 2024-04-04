import 'package:flutter/material.dart';
import 'components/base_layout.dart';
// Import the base layout

void main() {
  runApp(
    const MyApp(
      home: BaseLayout(),
    ),
  );
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
