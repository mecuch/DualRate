import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cryptocurrency/crytpo_main.dart';
import '../currency/curr_main.dart';
import '../utils/images.dart';
import '../utils/widgets.dart';
import 'about.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(ImageLoader.llogo,
              width: 320,
              height: 100),
              const SmallText(text: "v0.1"),
              const SizedBox(height: 70),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(targetPage: CurrencyMain(), imagePath: ImageLoader.curr_butt),
                  ImageButton(targetPage: CryptoCurrencyMain(), imagePath: ImageLoader.cryptocurr_butt),
                ],
              ),
              const SizedBox(height: 30),
              AppButton(text: "About",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const About(),
                      ),
                    );
              },),
              const SizedBox(height: 10),
              AppButton(text: "Exit",
                  onPressed: () {
                    SystemNavigator.pop();
                  },)
            ],
          ),
        ),
      ),
    );
  }
}