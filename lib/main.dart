import 'package:demo_1/views/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/home_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
