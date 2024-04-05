import 'package:flutter/material.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visits'),
      ),
      body: const Center(
        child: Text(
          'Content to be placed here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}