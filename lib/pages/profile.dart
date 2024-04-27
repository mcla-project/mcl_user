import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mcl_user/pages/profile_page/about_us.dart';
import 'package:mcl_user/pages/profile_page/feedback.dart';
// import 'package:mcl_user/pages/profile_page/logout.dart';
import 'package:mcl_user/pages/profile_page/visits.dart';
import 'package:mcl_user/pages/splash_screen/login.dart';
import 'profile_page/personal_info.dart';
import 'profile_page/view_card.dart';
import 'package:mcl_user/components/user_info.dart';

class ProfilePage extends StatefulWidget {
  final Function(Widget) navigateToPage;
  final Function(int) changePage;

  // final UserInfo userInfo;

  const ProfilePage(
      {super.key, required this.navigateToPage, required this.changePage});
  // required this.userInfo

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "userInfo.name",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "userInfo.username",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
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
                        widget.navigateToPage(
                          PersonalInfoPage(
                            // userInfo: UserInfo(
                            //   name: 'Merlin',
                            //   username: 'merlin123',
                            //   schoolOffice: 'PLM School',
                            //   address: '123 Main Street',
                            //   contactNumber: '555-1234',
                            // ),
                            navigateToPage: widget.navigateToPage,
                          ),
                        ); // Navigate to Personal Information page
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
                        widget.navigateToPage(
                          ViewCardPage(
                              // userInfo: UserInfo(
                              //   name: 'Merlin',
                              //   username: 'merlin123',
                              //   schoolOffice: 'PLM School',
                              //   address: '123 Main Street',
                              //   contactNumber: '555-1234',
                              // ),
                              ),
                        ); // Navigate to View Card page
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
                        widget.navigateToPage(
                          AboutUsPage(
                            // userInfo:
                            // userInfo, // Pass the userInfo received in the ProfilePage constructor
                            navigateToPage: widget.navigateToPage,
                          ),
                        ); // Navigate to About Us page
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
                        widget.changePage(3);
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
                        widget.navigateToPage(const VisitsPage());
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
                        widget.navigateToPage(
                          FeedbackPage(
                            // userInfo:
                            //     userInfo, // Pass the userInfo received in the ProfilePage constructor
                            navigateToPage: widget.navigateToPage,
                          ),
                        );
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

  Stream<List<UserModel>> _readData(){
    final userCollection = FirebaseFirestore.instance.collection("users");

    return userCollection.snapshots().map((qureySnapshot)
    => qureySnapshot.docs.map((e)
    => UserModel.fromSnapshot(e),).toList());
  }

}

class UserModel{
  final String? username;
  final String? adress;
  final int? age;
  final String? id;

  UserModel({this.id,this.username, this.adress, this.age});


  static UserModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return UserModel(
      username: snapshot['username'],
      adress: snapshot['adress'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "username": username,
      "age": age,
      "id": id,
      "adress": adress,
    };
  }
}
