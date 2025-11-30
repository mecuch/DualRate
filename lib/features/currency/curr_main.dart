import 'package:flutter/material.dart';

class CurrencyMain extends StatelessWidget {
  const CurrencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back to Main Menu!!'),
        ),
      ),
    );
  }
}