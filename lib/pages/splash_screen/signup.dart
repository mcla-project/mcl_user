import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/base_layout.dart';
import 'email.dart';
import 'login.dart';
import 'dart:math';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _acceptedTerms = false;

  // final FirebaseAuthService _auth = FirebaseAuthService();

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
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKey7 = GlobalKey<FormState>();
  final _formKey8 = GlobalKey<FormState>();
  final _formKey9 = GlobalKey<FormState>();
  final _formKey10 = GlobalKey<FormState>();

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

  Future<String> generateUniqueLibraryCardNumber() async {
  String number = generateLibraryCardNumber();
  
    while (await userExists(number)) {
      number = generateLibraryCardNumber();
    }
    
    return number;
  }

  String generateLibraryCardNumber() {
    var rng = Random();
    var currentYear = DateTime.now().year;
    var number = rng.nextInt(9000) + 1000; // from 1000 to 9999
    return '$currentYear$number';
  }

  Future<bool> userExists(String number) async {
    final result = await FirebaseFirestore.instance
      .collection('users')
      .where('libraryCardNumber', isEqualTo: number)
      .get();

    return result.docs.isNotEmpty;
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
                      Column(
                        children: [
                          Form(
                            key: _formKey1,
                            child: SizedBox(
                              width: 350,
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
                                onChanged: (value) {
                                  _formKey1.currentState!.validate();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey2,
                            child: SizedBox(
                              width: 350, 
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
                                  onChanged: (value) {
                                    _formKey2.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey3,
                            child: SizedBox(
                              width: 350, 
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
                                    final phoneRegExp =
                                        RegExp(r'^(\+?63|0)9\d{9}$');
                                    if (!phoneRegExp.hasMatch(value)) {
                                      return 'Enter a valid PH phone number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _formKey3.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey4,
                            child: SizedBox(
                              width: 350, 
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
                                    
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _formKey4.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey5,
                            child: SizedBox(
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
                                  onChanged: (value) {
                                    _formKey5.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey6,
                            child: SizedBox(
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
                                  onChanged: (value) {
                                    _formKey6.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey7,
                            child: SizedBox(
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
                                  onChanged: (value) {
                                    _formKey7.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey8,
                            child: SizedBox(
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
                                  onChanged: (value) {
                                    _formKey8.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey9,
                            child: SizedBox(
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
                                  onChanged: (value) {
                                    _formKey9.currentState!.validate();
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            child: SizedBox(
                              width: 350, 
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
                                dropdownColor: Colors
                                    .white, 
                                items: <String>['Male', 'Female']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        color: Colors
                                            .black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey10,
                            child: SizedBox(
                              width: 350, 
                              child: TextFormField(
                                  controller: _birthdateController,
                                  decoration: const InputDecoration(
                                    hintText: 'Birthday (MM-DD-YYYY)',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                  ),
                                  keyboardType: TextInputType
                                      .datetime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your birthday';
                                    }
                                    // Check if the entered value matches the desired format "MM-DD-YYYY"
                                    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid birthday format (MM/DD/YYYY)';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _formKey10.currentState!.validate();
                                  }),
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
                                  child: const Text(
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
                                backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
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
                    ],
                  ),
                ),
              ),
            )));
  }

  // Sign up user and store data in Firebase
  void _signUp() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('You must accept the terms and conditions to sign up.')),
      );
      return;
    }

    if (!passwordConfirmed()) {
      // Show error under the password confirmation field
      // Handle this based on your UI framework
      return;
    }
    // Proceed with the sign up

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
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmailPage()),
        );
      }
    } catch (e) {
      return null; 
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
  Future addUserDetails(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String address,
      String occupation,
      String sex,
      String birthdate,
      String office) async {
      String libraryCardNumber = await generateUniqueLibraryCardNumber();
    await FirebaseFirestore.instance.collection('users').add({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'birthday': Timestamp.fromDate(DateTime(2003, 12, 31)),
      'library_card_number': libraryCardNumber,
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
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
