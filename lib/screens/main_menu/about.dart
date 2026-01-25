import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  static const String _url = 'https://www.jakaś.strona.pl';

  Future<void> _openWebsite() async {
    final uri = Uri.parse(_url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Nie można otworzyć $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autor'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openWebsite,
          child: const Text('https://www.jakaś.strona.pl'),
        ),
      ),
    );
  }
}
