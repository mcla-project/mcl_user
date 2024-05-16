import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:mcl_user/pages/home.dart';

class OtpPage extends StatefulWidget {
  final EmailOTP myauth;

  const OtpPage({Key? key, required this.myauth}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late String _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'images/mnlcitylib_logo.png',
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Code has been sent to your email address. \nPlease enter the code below to verify.',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _otp =
                        value.trim(); // Remove leading and trailing whitespaces
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'OTP Code',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_otp.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please enter OTP"),
                  ));
                  return; // Exit early if OTP is empty
                }

                final isVerified = await widget.myauth.verifyOTP(otp: _otp);

                if (isVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP is verified"),
                  ));
                  Navigator.pushReplacement(
                    // Use pushReplacement to avoid going back to OTP page
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              },
              child: const Text(
                'Verify',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}
