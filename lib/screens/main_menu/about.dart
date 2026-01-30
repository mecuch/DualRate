import 'package:dualrate/screens/utils/colors.dart';
import 'package:dualrate/screens/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  static const String _url = 'https://github.com/mecuch';

  Future<void> _openWebsite() async {
    final uri = Uri.parse(_url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Cannot open $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLoader.main_green,
      appBar: AppBar(
        backgroundColor: ColorLoader.main_black,
        foregroundColor: ColorLoader.main_green,
        title: const SmallText(text: 'Author'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerySmallTextWhite(text: 'This flutter app is concepted'),
            const VerySmallTextWhite(text: 'by'),
            const VerySmallTextWhite(text: 'Marcin Mecuch Pecuch'),
            const VerySmallTextWhite(text: '2025-2026'),
            const SizedBox(height: 55),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorLoader.main_black,
                elevation: 6,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                )
              ),
              onPressed: _openWebsite,
              child: const VerySmallTextWhite(text: 'My GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
