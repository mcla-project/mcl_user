import 'package:flutter/material.dart';
import '../../models/faq.dart';
import '../../utils/get_user.dart';
import '../../utils/get_user_information.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  FAQPageState createState() => FAQPageState();
}

class FAQPageState extends State<FAQPage> {
  List<FAQItem> faqs = [
    FAQItem(question: "How do I search for books in the library catalog?", answer: "You can use the search bar at the top of the page."),
    FAQItem(question: "How do I access my account?", answer: "Log in by clicking the top right corner button."),
    FAQItem(question: "What should I do if I forgot my login credentials?", answer: "Use the 'Forgot Password' link on the login page."),
    FAQItem(question: "How do I contact the library for assistance or support?", answer: "You can reach out via email or call our support hotline."),
    FAQItem(question: "What is the process for returning borrowed books?", answer: "Books can be returned to the returns desk or via the after-hours drop-off."),
  ];

  UserDataService userDataService = UserDataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 63, 49),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ExpansionTile(
                  title: Text(faqs[index].question),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(faqs[index].answer),
                    ),
                  ],
                );
              },
              childCount: faqs.length,
            ),
          ),
        ],
      ),
    );
  }
}
