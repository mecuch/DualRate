import 'package:dualrate/screens/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/currency/currency_bloc.dart';
import '../../blocs/currency/currency_event.dart';
import '../../blocs/currency/currency_state.dart';
import '../../data/currency/currency_repository.dart';
import '../currency_det/currency_det.dart';
import '../utils/colors.dart';

class CurrencyMain extends StatelessWidget {
  const CurrencyMain({super.key});
  static const int visibleLimit = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorLoader.main_green,
        appBar: AppBar(
          title: const SmallText(text: "Currency Overwiew"),
          backgroundColor: Colors.black,
          foregroundColor: ColorLoader.main_green,
          elevation: 4,
          centerTitle: true
        ),
        body: BlocProvider(
          create: (_) =>
          CurrencyBloc(
            repository: CurrencyRepository(),
          )
            ..add(const CurrencyRequested()),
          child: BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyLoading || state is CurrencyInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CurrencyFailure) {
                return Center(
                  child: VerySmallTextWhite(text: 'Błąd: ${state.message}'),
                );
              }
              if (state is CurrencyLoaded) {
                final currencies = state.currencies.take(visibleLimit).toList();
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: currencies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final currency = currencies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorLoader.main_black,
                              elevation: 6,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                          ),
                        child: Row(
                          children: [
                            Image.asset(currency.flag, width: 45, height: 45,),
                            const SizedBox(width: 25),
                            VerySmallText(text: currency.code),
                            const SizedBox(width: 45),
                            VerySmallTextWhite(
                              text: '${currency.rate.toStringAsFixed(2)} PLN',
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => CurrencyDetailsScreen(code: currency.code,
                                name: currency.name,
                                flag: currency.flag,),
                            ),
                          );
                        },

                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}