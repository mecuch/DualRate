import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              const Text("BLoC"),
              const SizedBox(height: 70),
              Row(
                children: [
                  ElevatedButton(
                    child: Image.asset(ImageLoader.curr_butt,
                    width: 120,
                    height: 240,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const CurrencyMain(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Image.asset(ImageLoader.cryptocurr_butt,
                      width: 120,
                      height: 240,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const CurrencyMain(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 90),
              ElevatedButton(
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const About(),
                      ),
                    );
                  },
                  child: const ButtonText("About")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed:() {
                    SystemNavigator.pop();
                  },
                  child: const ButtonText("Exit"))
            ],
          ),
        ),
      ),
    );
  }
}