import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/get_doc_id.dart';

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  // Static DateTime to keep track of last write time
  static DateTime? lastWriteTime;
  static bool isProcessing = false; // Flag to prevent concurrent processing

  Future<void> toggleUserTimeEvent(BuildContext context) async {
    if (isProcessing) return;
    isProcessing = true;

    final DocIDService docIDService = DocIDService();
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user logged in. Unable to record time.")),
      );
      isProcessing = false;
      return;
    }
    
    String? userId = await docIDService.getDocId();
    var visitsCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('visits');
    var now = DateTime.now();

    if (lastWriteTime != null && now.difference(lastWriteTime!).inSeconds < 30) {
      // Throttle check: do not write if last write was less than 30 seconds ago
      isProcessing = false;
      return;
    }

    var lastVisit = await visitsCollection
        .orderBy('time_in', descending: true)
        .limit(1)
        .get();

    if (lastVisit.docs.isNotEmpty && !lastVisit.docs.first.data().containsKey('time_out')) {
      await lastVisit.docs.first.reference.update({
        'time_out': now,
      });
      showConfirmationDialog(context, "We hope you enjoyed your stay! See us again soon!");
    } else {
      await visitsCollection.add({
        'time_in': now,
      });
      showConfirmationDialog(context, "Welcome! You are officially inside the library!");
    }
    
    lastWriteTime = now; // Update last write time
    isProcessing = false; // Reset processing flag
  }

  void showConfirmationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Time Recorded"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/base_layout');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];
        if (scannedBarcodes.isEmpty) {
          return const Text('Scan QR!', style: TextStyle(color: Colors.white));
        }

        if (scannedBarcodes.first.rawValue == "Trigger") {
          toggleUserTimeEvent(context);
        }

        return const Text(
          "Scan recognized, processing...",
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}
