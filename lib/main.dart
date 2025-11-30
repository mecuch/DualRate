import 'package:dualrate/features/main_menu/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Navigation Basics',
      home: const MainMenu(),
      theme: ThemeData(
        fontFamily: "BerlinSansFBDemi-Bold"
      ),
      debugShowCheckedModeBanner: false));
}