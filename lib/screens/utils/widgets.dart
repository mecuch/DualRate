import 'package:flutter/material.dart';

import 'colors.dart';

class ImageButton extends StatelessWidget {
  final Widget targetPage;
  final String imagePath;

  const ImageButton({
    super.key,
    required this.targetPage,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: ColorLoader.main_green,
            width: 2,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => targetPage,
          ),
        );
      },
      child: Image.asset(imagePath,
          width: 120,
          height: 240),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  const SmallText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 25,
          color: ColorLoader.main_green,
          fontFamily: "BerlinSansFB"
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: ColorLoader.main_green,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
        child: Text(
            text,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: ColorLoader.main_green,
          fontFamily: "BerlinSansFB"
          ,),
      ),
      ),
    );
  }
}


