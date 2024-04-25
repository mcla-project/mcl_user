import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mcl_user/components/user_info.dart';

  class FeedbackPage extends StatelessWidget {
  final UserInfo userInfo;
  final Function(Widget) navigateToPage;

  const FeedbackPage({super.key, required this.userInfo, required this.navigateToPage,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
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
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
                    margin: const EdgeInsets.only(top: 10.0),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20), // Add space to the left of the icon
                          child: Icon(IconData(0xf631, fontFamily: 'MaterialIcons'),
                            size: 35,
                            color: Color.fromRGBO(1, 56, 34, 1.0),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Feedback',
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
                        const Center(
                          child: Text(
                            'Rate Your Experience',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),

                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(82, 82, 91, 1),
                              height: 1.5,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Weve been working hard on improving our application, so your feedback is important to us.',
                              ),
                            ],
                          ),
                        ),

                        Center(
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your feedback here..',
                            ),
                            maxLines: 8, // Allows multiple lines of input
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
