import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class WelcomeScreenBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 27, 66, 18),
          Color.fromARGB(255, 47, 255, 0)
        ],
      ).createShader(Rect.fromLTRB(size.width, 0 / 2, size.width, size.height));

    // Top border
    Path topPath = Path();
    topPath.moveTo(size.width, 0);
    topPath.quadraticBezierTo(
      -size.width * 0.3,
      size.height * 0.44,
      size.width * 0,
      size.height * 0,
    );
    topPath.lineTo(size.width, 0);
    topPath.close();
    canvas.drawPath(topPath, paint);
    final bottomPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 47, 255, 0),
          Color.fromARGB(255, 27, 66, 18)
        ],
      ).createShader(
          Rect.fromLTRB(0, size.height / 2, size.width, size.height));

    // Bottom border
    Path bottomPath = Path();
    bottomPath.moveTo(0, size.height);
    bottomPath.quadraticBezierTo(
      size.width * 1.3,
      size.height * 0.6,
      size.width,
      size.height,
    );
    bottomPath.lineTo(0, size.height);
    bottomPath.close();
    canvas.drawPath(bottomPath, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            painter: WelcomeScreenBorderPainter(),
            child: Container(),
          ),
          Column(
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
                          SizedBox(
                            width: 200, // Set the width of the button
                            height: 50, // Set the height of the button
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
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
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200, // Set the width of the button
                            height: 50, // Set the height of the button
                            child: ElevatedButton(
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}