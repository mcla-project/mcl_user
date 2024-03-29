import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'navigation_bar.dart';
import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/recents.dart';
import '../pages/scanner.dart';
import '../pages/favorites.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  BaseLayoutState createState() => BaseLayoutState();
}

class BaseLayoutState extends State<BaseLayout> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    const HomePage(),
    const RecentsPage(),
    const ScannerPage(),
    const FavoritesPage(),
    ProfilePage(navigateToPage: navigateToPage), // Pass the navigateToPage method dynamically
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scaffold(
        appBar: const CustomAppBar(),
        body: page,
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
