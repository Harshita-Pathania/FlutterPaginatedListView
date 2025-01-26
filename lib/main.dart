// Importing libraries and custom widgets
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/home_page.dart';

void main() {
  runApp(
    // Wrapping with provider scope to enable RiverPod's state management
    ProviderScope(
      child: MaterialApp(
        // Setting HomePage as default page
        home: HomePage(),
        // Removing debug banner
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
