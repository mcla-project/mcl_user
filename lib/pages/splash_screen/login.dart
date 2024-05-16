import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/base_layout.dart';
import 'email.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String _errorMessage = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmailPage()),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Some error occurred"),
            ),
          );
        }
      }
    } catch (e) {
      // Update the error message state
      setState(() {
        _errorMessage = 'You have entered an invalid email or password.';
      });
    }
  }

  void _navigateToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()), // Navigate to SignUpScreen
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Image.asset(
                    'images/mnlcitylib_logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'WELCOME BACK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // Email field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Password field
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: _signIn,
                child: SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Add some space
            Center(
              child: GestureDetector(
                onTap: _navigateToSignUpScreen, // Navigate to SignUpScreen
                child: RichText(
                  text: const TextSpan(
                    text: 'Not a member? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
