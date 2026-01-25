import 'package:dualrate/screens/main_menu/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'DualRate',
      home: const MainMenu(),
      theme: ThemeData(
        fontFamily: "BerlinSansFBDemi-Bold"
      ),
      debugShowCheckedModeBanner: false));
}