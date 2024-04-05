import 'package:flutter/material.dart';
import 'package:mcl_user/components/user_info.dart';
import '../../components/base_layout.dart';

class ConfirmProfilePage extends StatelessWidget {
  final UserInfo userInfo;
  final Function(Widget) navigateToPage;

  const ConfirmProfilePage({
    super.key,
    required this.userInfo,
    required this.navigateToPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Personal Information'),
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
                          userInfo.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(userInfo.username,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(userInfo.name),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(userInfo.schoolOffice),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(userInfo.address),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(userInfo.contactNumber),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF013822)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const BaseLayout()),
                      );
                    },
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
