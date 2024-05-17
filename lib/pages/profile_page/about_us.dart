import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {

  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
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
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "userInfo.name",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text("userInfo.username",
                            style: TextStyle(
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
                    margin: const EdgeInsets.only(top: 10.0),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15), // Add space to the left of the icon
                          child: Icon(IconData(0xf713, fontFamily: 'MaterialIcons'),
                            size: 35,
                            color: Color.fromRGBO(1, 56, 34, 1.0),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 56, 34, 1.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        RichText(
                          textAlign: TextAlign.justify,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(82, 82, 91, 1),
                              height: 1.5,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Welcome to ',
                              ),
                              TextSpan(
                                text: 'ManilaLib Access',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '! Your digital gateway to accessing a world of knowledge and literature. Our app represents a transformative leap from traditional library systems to a modern, user-friendly digital platform.\n',
                              ),
                            ],
                          ),
                        ),

                        const Center(
                          child: Text(
                            'Our Vision',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),

                        RichText(
                          textAlign: TextAlign.justify,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(82, 82, 91, 1),
                              height: 1.5,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'At ',
                              ),
                              TextSpan(
                                text: 'ManilaLib Access',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ', we believe in making the library experience more accessible, convenient, and enjoyable for everyone. Our vision is to harness the power of technology to empower our users and enhance their engagement with our library’s vast resources.\n',
                              ),
                            ],
                          ),
                        ),

                      ],
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
