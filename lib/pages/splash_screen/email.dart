import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import '../../components/base_layout.dart';
import 'otp.dart'; // Importing the OTP page

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailController = TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
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
                const SizedBox(height: 50),
                const Text(
                  'Enter your email address to receive a \nverification code',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () async {
                      myauth.setConfig(
                        appEmail: "contact@hdevcoder.com",
                        appName: "Email OTP",
                        userEmail: emailController.text,
                        otpLength: 6,
                        otpType: OTPType.digitsOnly,
                      );
                      if (await myauth.sendOTP()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                        ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPage(myauth: myauth),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Send Code',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // SizedBox(
                //   width: 350,
                //   child: ElevatedButton(
                //     onPressed: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const BaseLayout()),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.green.shade900,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     child: const Text(
                //       'Home',
                //       style: TextStyle(fontSize: 20, color: Colors.white),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
