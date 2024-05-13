import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/base_layout.dart';
import 'email.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _acceptedTerms = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _officeController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _confirmpasswordController.dispose();
    _addressController.dispose();
    _occupationController.dispose();
    _officeController.dispose();
    _sexController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    final phoneRegExp = RegExp(r'^(\+?63|0)9\d{9}$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid PH phone number';
    }
    return null;
  }

  String? _selectedSex;

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
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _firstnameController,
                                decoration: const InputDecoration(
                                  hintText: 'First Name',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'First name is required';
                                  }
                                  if (value.contains(RegExp(r'[0-9]'))) {
                                    return 'First name cannot contain numbers';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _lastnameController,
                                decoration: const InputDecoration(
                                  hintText: 'Last Name',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Last name is required';
                                  }
                                  if (value.contains(RegExp(r'[0-9]'))) {
                                    return 'Last name cannot contain numbers';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  hintText: 'Phone Number',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone number is required';
                                  }
                                  final phoneRegExp = RegExp(
                                      r'^(\+?63|0)9\d{9}$');
                                  if (!phoneRegExp.hasMatch(value)) {
                                    return 'Enter a valid PH phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  // Use the built-in email validation provided by TextFormField
                                  if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
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
                                        _obscureTextPassword =
                                        !_obscureTextPassword;
                                      });
                                    },
                                    child: Icon(
                                      _obscureTextPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  // Minimum length validation
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  // Uppercase letter validation
                                  if (!value.contains(RegExp(r'[A-Z]'))) {
                                    return 'Password must contain at least one uppercase letter';
                                  }
                                  // Lowercase letter validation
                                  if (!value.contains(RegExp(r'[a-z]'))) {
                                    return 'Password must contain at least one lowercase letter';
                                  }
                                  // Number validation
                                  if (!value.contains(RegExp(r'[0-9]'))) {
                                    return 'Password must contain at least one number';
                                  }
                                  // Return null if the password meets all criteria
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _confirmpasswordController,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  hintText: 'Address',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Address is required';
                                  }
                                  // You can add additional validation logic here if needed
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _occupationController,
                                decoration: const InputDecoration(
                                  hintText: 'Occupation',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Occupation is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _officeController,
                                decoration: const InputDecoration(
                                  hintText: 'Office/School',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Office/School is required';
                                  }
                                  // You can add additional validation logic here if needed
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: DropdownButtonFormField<String>(
                                value: _selectedSex,
                                decoration: const InputDecoration(
                                  hintText: 'Sex',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedSex = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Sex field is required';
                                  }
                                  return null;
                                },
                                items: <String>['Male', 'Female'].map((
                                    String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TextFormField(
                                controller: _birthdateController,
                                decoration: const InputDecoration(
                                  hintText: 'Birthday (MM-DD-YYYY)',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                ),
                                keyboardType: TextInputType.datetime,
                                // Set keyboard type to handle dates
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your birthday';
                                  }
                                  // Check if the entered value matches the desired format "MM-DD-YYYY"
                                  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(
                                      value)) {
                                    return 'Please enter a valid birthday format (MM/DD/YYYY)';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: _acceptedTerms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _acceptedTerms = value ?? false;
                                      if (_acceptedTerms) {
                                        _showTermsAndConditionsDialog(context);
                                      }
                                    });
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _acceptedTerms = !_acceptedTerms;
                                      });
                                      if (_acceptedTerms) {
                                        _showTermsAndConditionsDialog(context);
                                      }
                                    },
                                    child: Text(
                                      'By clicking “Sign Up” I agree that I have read and accepted the Terms and Conditions.',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 350,
                              child: ElevatedButton(
                                onPressed: _acceptedTerms ? _signUp : null,
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
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (
                                      context) => const LoginScreen()),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: 'I am a member! ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ));
  }

  // Sign up user and store data in Firebase
  void _signUp() async {
    if (!passwordConfirmed()) {
      // Show error under the password confirmation field
      // Handle this based on your UI framework
      return;
    }

    if (_validatePhoneNumber(_phoneController.text.trim()) != null) {
      // Show error under the phone number field
      // Handle this based on your UI framework
      return;
    }

    try {
      // Attempt to create the user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // On successful creation, add user details to Firestore
      await addUserDetails(
        _firstnameController.text.trim(),
        _lastnameController.text.trim(),
        _emailController.text.trim(),
        _phoneController.text.trim(),
        _addressController.text.trim(),
        _occupationController.text.trim(),
        _officeController.text.trim(),
        _sexController.text.trim(),
        _birthdateController.text.trim(),
      );

      // After successful registration, navigate to the EmailPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailPage()),
      );
    } catch (e) {
      // Handle errors in case of a failure
      print('Failed to sign up: $e'); // For debugging, print the error
    }
  }

  // Check if the password and confirm password match
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  // Store user details in Firestore
  Future addUserDetails(String firstName, String lastName, String email,
      String phoneNumber, String address, String occupation, String sex,
      String birthdate, String office) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'birthday': Timestamp.fromDate(DateTime(2003, 12, 31)),
      'library_card_number': '202103',
      'occupation': occupation,
      'office': office,
      'sex': sex,
      'photo_url': 'https://via.placeholder.com/150',
      'created_at': DateTime.now(),
    });
  }

  void navigateToBaseLayout(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const BaseLayout()),
    );
  }

  // Enconst sure this function is a member of your StatefulWidget class
  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Terms and Conditions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Welcome to MCLA!  "
                "\n\nThese terms and conditions outline the rules and regulations for the use of Manila City Library App's Website, located at mclapp.com.  "
                "\n\nBy accessing this website we assume you accept these terms and conditions. Do not continue to use MCLA if you do not agree to take all of the terms and conditions stated on this page.  "
                "\n\nThe following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 'Client', 'You' and 'Your' refers to you, the person log on this website and compliant to the Company's terms and conditions. 'The Company', 'Ourselves', 'We', 'Our' and 'Us', refers to our Company. 'Party', 'Parties', or 'Us', refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client's needs in respect of provision of the Company's stated services, in accordance with and subject to, prevailing law of ph.  "
                "\n\nAny use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}