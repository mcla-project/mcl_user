import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF013822),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('images/mnlcitylib_logo.png', height: 40),
          const Text(
            'Manila City Library',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Nunito', // ADD FONT
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 30), // Formatting
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
