import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../utils/get_doc_id.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  VisitsPageState createState() => VisitsPageState();
}

class VisitsPageState extends State<VisitsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? docId;
  final DocIDService docIDService = DocIDService();

  @override
  void initState() {
    super.initState();
    fetchDocId();
  }

  void fetchDocId() async {
    docId = await docIDService.getDocId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visits',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(docId)
            .collection('visits')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return visitItem(
                timeIn: data['time_in'],
                checkIn: DateFormat.jm().format(
                    data['time_in'].toDate()),
                checkOut: data['time_out'] != null
                    ? DateFormat.jm().format(data['time_out'].toDate())
                    : 'N/A',
                iconPath: 'assets/icon.png',
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget visitItem({
    required Timestamp timeIn,
    required String checkIn,
    required String checkOut,
    required String iconPath,
  }) {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(timeIn.toDate());

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 1,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Check in: $checkIn",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Check out: $checkOut",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
