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

  static DateTime? lastWriteTime;
  static bool isProcessing = false;

  Future<void> toggleUserTimeEvent(BuildContext context) async {
    if (isProcessing) return;
    isProcessing = true;

    final DocIDService docIDService = DocIDService();
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("No user logged in. Unable to record time.")),
      );
      isProcessing = false;
      return;
    }

    String? userId = await docIDService.getDocId();
    var visitsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('visits');
    var now = DateTime.now();

    if (lastWriteTime != null &&
        now.difference(lastWriteTime!).inSeconds < 30) {
      isProcessing = false;
      return;
    }

    var lastVisit = await visitsCollection
        .orderBy('time_in', descending: true)
        .limit(1)
        .get();

    if (lastVisit.docs.isNotEmpty &&
        !lastVisit.docs.first.data().containsKey('time_out')) {
      await lastVisit.docs.first.reference.update({'time_out': now});
      showConfirmationDialog(
          context, "We hope you enjoyed your stay! See us again soon!");
    } else {
      await visitsCollection.add({'time_in': now});
      showConfirmationDialog(
          context, "Welcome! You are officially inside the library!");
    }

    lastWriteTime = now;
    isProcessing = false;
  }

  Future<void> toggleBookUsageEvent(
      BuildContext context, String barcodeValue) async {
    if (isProcessing) return;
    isProcessing = true;

    final DocIDService docIDService = DocIDService();
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("No user logged in. Unable to manage book.")),
      );
      isProcessing = false;
      return;
    }

    List<String> parts = barcodeValue.split(';');
    if (parts.length != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid barcode format.")),
      );
      isProcessing = false;
      return;
    }
    String bookId = parts[0];
    String bookTitle = parts[1];

    String? userId = await docIDService.getDocId();
    var userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    var booksCollection = userDoc.collection('borrows');
    var now = DateTime.now();

    if (lastWriteTime != null &&
        now.difference(lastWriteTime!).inSeconds < 30) {
      isProcessing = false;
      return;
    }

    var querySnapshot = await booksCollection
        .where('book_id', isEqualTo: bookId)
        .orderBy('time_borrowed', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty &&
        !querySnapshot.docs.first.data().containsKey('time_returned')) {
      await querySnapshot.docs.first.reference.update({'time_returned': now});
      showConfirmationDialog(context, "Book returned: $bookTitle");
    } else {
      await booksCollection.add({
        'book_id': bookId,
        // 'book_title': bookTitle, // Include book title in the document
        'time_borrowed': now,
        // 'time_returned' is not set initially
      });
      await userDoc.update({
        'recents': FieldValue.arrayUnion([bookId])
      });
      showConfirmationDialog(context, "Book borrowed: $bookTitle");
      // Add bookId and bookTitle to the 'recents' array in the user's document
    }

    lastWriteTime = now;
    isProcessing = false;
  }

  void showConfirmationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Action Recorded"),
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
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text('Scan QR!', style: TextStyle(color: Colors.white));
        }

        final BarcodeCapture barcodeCapture = snapshot.data as BarcodeCapture;
        final Barcode barcode = barcodeCapture.barcodes.first;

        if (barcode.rawValue == null) {
          return const Text(
            "Invalid QR code scanned.",
            style: TextStyle(color: Colors.red),
          );
        } else {
          String rawValue = barcode.rawValue!;
          if (rawValue == "Trigger") {
            toggleUserTimeEvent(context);
          } else if (barcode.type == BarcodeType.text) {
            toggleBookUsageEvent(context, rawValue);
          }
        }
        return const Text(
          "Scan recognized, processing...",
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}
