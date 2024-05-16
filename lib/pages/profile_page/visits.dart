import 'package:flutter/material.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visits'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          visitItem(
            date: "December 31, 2024",
            checkIn: "01:02 PM",
            checkOut: "03:02 PM",
            iconPath: 'assets/icon.png',
          ),
          visitItem(
            date: "December 13, 2024",
            checkIn: "01:02 PM",
            checkOut: "03:02 PM",
            iconPath: 'assets/icon.png',
          ),
          // Add more visit items here if needed
        ],
      ),
    );
  }

  Widget visitItem({required String date, required String checkIn, required String checkOut, required String iconPath}) {
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
                  date,
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
