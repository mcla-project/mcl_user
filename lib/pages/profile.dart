import 'package:flutter/material.dart';
import 'package:mcl_user/pages/profile_page/about_us.dart';
import 'package:mcl_user/pages/profile_page/feedback.dart';
import 'package:mcl_user/pages/profile_page/logout.dart';
import 'package:mcl_user/pages/profile_page/visits.dart';
import 'profile_page/personal_info.dart';
import 'profile_page/view_card.dart';
import 'package:mcl_user/components/user_info.dart';

class ProfilePage extends StatelessWidget {
  final Function(Widget) navigateToPage;
  final Function(int) changePage;

  const ProfilePage({super.key, required this.navigateToPage, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text('Username',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
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
                        navigateToPage(const PersonalInfoPage());
                        // Navigate to Personal Information page
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
                      title: const Text('View Card'),
                      onTap: () {
                        navigateToPage(ViewCardPage(userInfo: UserInfo(
                          name: 'Merlin',
                          username: 'merlin123',
                          schoolOffice: 'PLM School',
                          address: '123 Main Street',
                          contactNumber: '555-1234',
                        )));
                        // Navigate to View Card page
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
                        navigateToPage(const AboutUsPage());
                        // Navigate to About Us page
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
                        changePage(3);
                        // Navigate to Favorites page
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
                        navigateToPage(const VisitsPage());
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
                      leading: const Icon(Icons.feedback),
                      title: const Text('Feedback'),
                      onTap: () {
                        navigateToPage(const FeedbackPage());
                        // Navigate to Feedback page
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
                        navigateToPage(const LogoutPage());
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
}
