// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mcl_user/pages/favorites.dart';
import 'package:mcl_user/pages/profile_page/about_us.dart';
import 'package:mcl_user/pages/profile_page/feedback.dart';
import 'package:mcl_user/pages/profile_page/visits.dart';
import 'package:mcl_user/pages/splash_screen/login.dart';
import 'package:mcl_user/pages/profile_page/faqs.dart';
import 'profile_page/chatbot.dart';
import 'profile_page/personal_info.dart';
import 'home/all_books.dart';
import '../utils/get_user_information.dart';
import '../utils/get_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  UserDataService userDataService = UserDataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 63, 49), // Set background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
          color: Colors.white, // Set icon color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFF013822),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    UserInfoWidget(
                        getDocData: userDataService.getDocData,
                        fieldName: 'photo_url',
                        color: Colors.white),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            UserInfoWidget(
                                getDocData: userDataService.getDocData,
                                fieldName: 'first_name',
                                color: Colors.white),
                            UserInfoWidget(
                                getDocData: userDataService.getDocData,
                                fieldName: 'last_name',
                                color: Colors.white),
                          ],
                        ),
                        UserInfoWidget(
                            getDocData: userDataService.getDocData,
                            fieldName: 'library_card_number',
                            color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Personal Information'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const PersonalInfoPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.credit_card),
                      title: const Text('View Catalogue'),
                      onTap: () {
                        Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AllBooksPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About Us'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const AboutUsPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Favorites'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const FavoritesPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('Visits'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const VisitsPage()),
                        );
                        // Navigate to Visits page
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.feedback_rounded),
                      title: const Text('Feedback'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.menu_book_rounded),
                      title: const Text('FAQs'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const FAQPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.android_outlined),
                      title: const Text('MCLA Chatbot'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ChatPage()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                        // Perform logout
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getUserProfileImageUrl(String userId) async {
    try {
      String imageUrl = await FirebaseStorage.instance
          .ref(
              'user_profiles/$userId/profile.jpg') // Assuming a standard path format
          .getDownloadURL();
      return imageUrl;
    } catch (e) {
      return 'https://via.placeholder.com/150'; // Fallback image URL
    }
  }
}
