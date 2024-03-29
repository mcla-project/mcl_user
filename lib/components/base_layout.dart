import 'package:flutter/material.dart';
import 'package:mcl_user/pages/profile_page/update_profile.dart';
import 'app_bar.dart';
import 'navigation_bar.dart';
import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/recents.dart';
import '../pages/scanner.dart';
import '../pages/favorites.dart';
import '../pages/profile_page/personal_info.dart';

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
    ProfilePage(navigateToPage: navigateToPage, changePage: changePage), // Navigate to the profile page subpages
    UpdateProfilePage(navigateToPage: navigateToPage), // Navigate to the UpdateProfileScreen
  ];

  // Handles the bottom navigation bar tap event 
  void _onItemTapped(int index) {
    // Check if the current page is not the first page
    bool isSecondPage = Navigator.of(context).canPop();
    if (isSecondPage) {
      // Pop the current page until it reaches the first page
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    // Set the current index determined by the bottom navigation bar
    setState(() {
      _currentIndex = index;
    });
  }
  // Handles the Favorite page tap event on Profile page
  void changePage(int index) {
    _onItemTapped(index);
  }

  // Navigation for the profile page subpages
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
