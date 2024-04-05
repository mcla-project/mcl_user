import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_user/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../components/base_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    controller: _usernameController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                    onPressed: () => _signUp(),
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
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.sigUpWithEmailAndPassword(email, password);

    if (user != null) {
      print('Sign up successful');
      navigateToBaseLayout(context);
    }
    else {
      print('Sign up failed');
  }
}

void navigateToBaseLayout(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => const BaseLayout()),
  );
}
}