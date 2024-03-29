import 'package:flutter/material.dart';
import '../../pages/profile_page/personal_info.dart';

class ProfilePage extends StatelessWidget {
  final Function(Widget) navigateToPage;

  const ProfilePage({super.key, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('Username', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal Information'),
              onTap: () {
                navigateToPage(const PersonalInfoPage());
                // Navigate to Personal Information page
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('View Card'),
              onTap: () {
                // Navigate to View Card page
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                // Navigate to About Us page
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                // Navigate to Favorites page
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Visits'),
              onTap: () {
                // Navigate to Visits page
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                // Navigate to Feedback page
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Perform logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
