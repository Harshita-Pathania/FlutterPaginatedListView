// Importing the Material Design library for Flutter
import 'package:flutter/material.dart';

// Custom widget for appBar implenting PreferredSizeWidget
class custom_app_bar extends StatelessWidget implements PreferredSizeWidget {
  const custom_app_bar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Using built in appBar widget
    return AppBar(
      // Change values to customize accordingly
      backgroundColor: Color(0xFFE25E36),
      title: Text("ABC Company",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  // Sets height to standard appBar size
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}