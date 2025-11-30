import 'package:flutter/material.dart';

class CryptoCurrencyMain extends StatelessWidget {
  const CryptoCurrencyMain({super.key});

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