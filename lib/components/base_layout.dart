import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'navigation_bar.dart';
import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/recents.dart';
import '../pages/scanner.dart';
import '../pages/favorites.dart';
// import 'package:mcl_user/components/user_info.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  BaseLayoutState createState() => BaseLayoutState();
}

class BaseLayoutState extends State<BaseLayout> {
  final int _profilePageIndex = 4;
  int _currentIndex = 0;

  List<Widget> get _pages => [
        const HomePage(),
        const RecentsPage(),
        const ScannerPage(),
        const FavoritesPage(),
        const ProfilePage(),
      ];

  // Handles the bottom navigation bar tap event
  void _onItemTapped(int index) {
    // Check if the current index is the profile page index
    if (_currentIndex == _profilePageIndex && index == _profilePageIndex) {
      // Pop the current page until it reaches the first page of the profile
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // Set the current index determined by the bottom navigation bar
      setState(
        () {
          _currentIndex = index;
        },
      );
    }
  }

  // Handles the Favorite page tap event on Profile page
  void changePage(int index) {
    _onItemTapped(index);
  }

  // Navigation for the profile page subpages
  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: const CustomAppBar(),
          body: page,
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
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
