import 'package:flutter/material.dart';
import 'similar.dart';

class NoBooksFoundWidget extends StatelessWidget {
  final List<String> recommendations;

  const NoBooksFoundWidget({
    Key? key,
    this.recommendations = const [
      'Dekada ’70',
      'The Wimpy Kid',
      'Attack on Titan'
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/no_result.png', width: 150),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'No Results Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            'Perhaps you\'d like these titles instead',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 10),
          const SimilarBooks(),
          const SizedBox(height: 50),
          // Wrap(
          //   spacing: 8.0,
          //   runSpacing: 4.0,
          //   children: recommendations
          //       .map((title) => ElevatedButton(
          //             onPressed: () {
          //             },
          //             style: ElevatedButton.styleFrom(),
          //             child: Text(title),
          //           ))
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
