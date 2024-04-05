import 'package:flutter/material.dart';
import './components/base_layout.dart';
import './pages/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      initialRoute: '/', 
      routes: {
        '/': (context) => const AnimatedSplashScreen(), 
        '/base_layout': (context) => const BaseLayout(), 
      },
    );
  }
}
