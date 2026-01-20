import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String text;

  const ButtonText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 35,
        color: Color(0xFF028040),
        fontFamily: 'Berlin Sans FB Demi Bold',
      ),
    );
  }
}