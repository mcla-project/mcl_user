import 'package:flutter/material.dart';

class ViewCardPage extends StatelessWidget {
  const ViewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Card'),
      ),
      body: const Center(
        child: Text(
          'Hallooo',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}