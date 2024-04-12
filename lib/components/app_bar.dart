import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the height of the AppBar based on your design requirements.
    double appBarHeight = 90.0;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor:
          Colors.transparent, // Ensures no color is behind the ellipse.
      elevation: 0, // Removes the shadow.
      flexibleSpace: Container(
        height: appBarHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20, // Position of the appbar from the top.
              child: Container(
                width: 310,
                height: appBarHeight - 20, // For padding.
                decoration: BoxDecoration(
                  color: const Color(0xFF013822),
                  borderRadius: BorderRadius.circular(
                      50), // Shapes the appbar into an ellipse.
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Image.asset(
                        "images/mnlcitylib_logo.png",
                        width: 50.72,
                        height: 46,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Manila City Library',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(70); // Set this to your required AppBar height.
}
