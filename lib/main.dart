import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './components/base_layout.dart';
import './pages/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   if (kIsWeb) {
     await Firebase.initializeApp(
       options: const FirebaseOptions(
       apiKey: "AIzaSyD_4uLrDvoiPhfPK8aw4QtwlwxCA6mAFls",
       appId: "1:815166244171:web:f523c6b7f9b89ab88b14ce",
       messagingSenderId: "815166244171",
       projectId: "mcla-51bb1",
     ));
   }
  await Firebase.initializeApp();

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
