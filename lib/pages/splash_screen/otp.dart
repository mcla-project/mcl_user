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
  bool _isOtpInvalid = false; // State variable to track if OTP is invalid

  @override
  void initState() {
    super.initState();
    _otp = '';
  }

  Future<void> _resendOtp() async {
    // Logic to resend the OTP
    await widget.myauth.sendOTP();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("A new OTP has been sent to your email."),
    ));
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
              const SizedBox(height: 20),
              TextField(
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
                    return; // Exit early if OTP is empty
                  }

                  print("OTP entered: $_otp"); // Debug print
                  final isVerified = await widget.myauth.verifyOTP(otp: _otp);
                  print("Is OTP verified: $isVerified"); // Debug print

                  if (isVerified) {
                    print("OTP is verified"); // Debug print
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP is verified"),
                    ));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    print("Invalid OTP");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid OTP"),
                    ));
                    setState(() {
                      _isOtpInvalid =
                          true; // Show the resend button if OTP is invalid
                    });
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
              if (_isOtpInvalid) // Show the resend button if OTP is invalid
                TextButton(
                  onPressed: () async {
                    await _resendOtp();
                    setState(() {
                      _isOtpInvalid =
                          false; // Hide the resend button after resending the OTP
                    });
                  },
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(color: const Color(0xFF1B5E20)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
