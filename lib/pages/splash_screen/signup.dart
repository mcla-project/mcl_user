import 'package:flutter/material.dart';
import '../../components/base_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
      },
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Sign Up'),
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
                const SizedBox(height: 10),
                const Text(
                  'CREATE YOUR ACCOUNT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350, // Adjust the width as needed
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350, // Adjust the width as needed
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350, // Adjust the width as needed
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    obscureText: _obscureTextPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPassword = !_obscureTextPassword;
                          });
                        },
                        child: Icon(
                          _obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    obscureText: _obscureTextConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextConfirmPassword =
                                !_obscureTextConfirmPassword;
                          });
                        },
                        child: Icon(
                          _obscureTextConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {
                        // Implement checkbox state change
                      },
                    ),
                    const Flexible(
                      child: Text(
                        'By clicking “Sign Up” I agree that I have read and accepted the Terms and Conditions.',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () => navigateToBaseLayout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}

void navigateToBaseLayout(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => const BaseLayout()),
  );
}
