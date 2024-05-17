import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:mcl_user/components/base_layout.dart';
import 'dart:async';

class OtpPage extends StatefulWidget {
  final EmailOTP myauth;

  const OtpPage({Key? key, required this.myauth}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late String _otp;
  final String _errorMessage = '';
  late Timer _timer;
  int _start = 180;

  @override
  void initState() {
    super.initState();
    _otp = '';
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> _resendOtp() async {
    await widget.myauth.sendOTP();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("A new OTP has been sent to your email."),
    ));
    setState(() {
      _start = 180;
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              const SizedBox(height: 20),
              const Text(
                'Code has been sent to your email address. \nPlease enter the code below to verify.',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 5),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _otp = value.trim();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'OTP Code',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_otp.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter OTP"),
                    ));
                    return;
                  }

                  final isVerified = await widget.myauth.verifyOTP(otp: _otp);

                  if (isVerified) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP is verified"),
                    ));
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const BaseLayout()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid OTP"),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green.shade900,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                child: const Text(
                  'Verify',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Time remaining: ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
              ),
              TextButton(
                onPressed: _start > 0 ? null : _resendOtp,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      return const Color(
                          0xFF1B5E20); // Use the original color when enabled
                    },
                  ),
                ),
                child: const Text(
                  'Resend Code',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
