import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatelessWidget {
  // final Function(String) onCodeScanned;
  // required this.onCodeScanned

  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR READER'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.grey.shade800,
                        size: 128,
                      ),
                    ),
                  ),
                ),
                const Text('Place the QR code within the frame to scan',
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.qr_code_2, color: Colors.white),
                  label: const Text(
                    'Generate QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () {
                    // TODO: Add generate QR code logic
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF013822)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
