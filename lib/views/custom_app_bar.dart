import 'package:flutter/material.dart';


class custom_app_bar extends StatelessWidget implements PreferredSizeWidget {
  const custom_app_bar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}