import 'package:flutter/material.dart';

class RecentsPage extends StatelessWidget {
  const RecentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recents'),
      ),
      body: const Center(
        child: Text(
          'Recentususus',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}