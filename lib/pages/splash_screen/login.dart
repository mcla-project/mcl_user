import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/base_layout.dart';
import 'signup.dart';

class FirstLoginScreen extends StatelessWidget {
  const FirstLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Image.asset(
                    'images/mnlcitylib_logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NextLoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .green.shade900, // Set the button color to green
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the corner radius
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .green.shade900, // Set the button color to green
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the corner radius
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextLoginScreen extends StatefulWidget {
  const NextLoginScreen({Key? key}) : super(key: key);

  @override
  NextLoginScreenState createState() => NextLoginScreenState();
}

class NextLoginScreenState extends State<NextLoginScreen> {
  bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigning = false;

  Future<void> _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      setState(() {
        _isSigning = false;
      });

      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User is successfully signed in"),
          ),
        );
        Navigator.pushNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Some error occurred"),
          ),
        );
      }
    } catch (e) {
      print("Error signing in: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing in: $e"),
        ),
      );
      setState(() {
        _isSigning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) async {},
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text('Login'),
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
                  ],
                ),
                const SizedBox(height: 20),
                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                const SizedBox(height: 20),
                // Login button
                SizedBox(
                  width: double.infinity,
                  child: _isSigning
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _signIn,
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                  // style: ElevatedButton.styleFrom(
                  //   padding: const EdgeInsets.symmetric(vertical: 15),
                  //   backgroundColor: Colors.green.shade900,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                  // child: const Text(
                  //   'Sign In',
                  //   style: TextStyle(fontSize: 20, color: Colors.white),
                  // ),
                ),
              ],
            ),
          ),
        ));
  }
}

void navigateToBaseLayout(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => const BaseLayout()),
  );
}
