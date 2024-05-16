import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scanner/scanned_barcode_label.dart';
import 'scanner/scanner_error_widget.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  ScannerPageState createState() => ScannerPageState();
}

class ScannerPageState extends State<ScannerPage> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  Timer? _activationTimer;
  bool _showLabel = false; // State to control visibility of ScannedBarcodeLabel

  void _toggleLabelVisibility() {
    if (_showLabel) {
      // Hide the label and reset the timer after 30 seconds
      setState(() => _showLabel = false);
      _activationTimer?.cancel();
      _activationTimer = Timer(const Duration(seconds: 30), () {
        setState(
            () => _showLabel = true); // Show the label again after 30 seconds
      });
    } else {
      // Show the label
      setState(() => _showLabel = true);
    }
  }

  @override
  void initState() {
    super.initState();
    // Initially allow label to be shown
    _showLabel = true;
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: Offset(MediaQuery.of(context).size.width * 0.375,
          MediaQuery.of(context).size.height * 0.20),
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.42,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('QR Scanner')),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.45,
          child: Stack(
            children: [
              MobileScanner(
                fit: BoxFit.contain,
                controller: controller,
                scanWindow: scanWindow,
                errorBuilder: (context, error, child) =>
                    ScannerErrorWidget(error: error),
              ),
              CustomPaint(
                painter: ScannerOverlay(scanWindow: scanWindow),
              ),
              if (_showLabel)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ScannedBarcodeLabel(barcodes: controller.barcodes),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLabelVisibility,
        child: const Icon(Icons.flashlight_on),
      ),
    );
  }

  @override
  void dispose() {
    _activationTimer
        ?.cancel(); // Make sure to cancel the timer to avoid memory leaks
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  final Rect scanWindow;
  final double borderRadius = 12.0;

  ScannerOverlay({required this.scanWindow});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawPath(
        Path.combine(PathOperation.difference, backgroundPath, cutoutPath),
        backgroundPaint);
    canvas.drawRRect(
        RRect.fromRectAndCorners(scanWindow,
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius)),
        borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
