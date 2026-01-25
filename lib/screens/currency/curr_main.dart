import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/currency/currency_bloc.dart';
import '../../blocs/currency/currency_event.dart';
import '../../blocs/currency/currency_state.dart';
import '../../data/currency/currency_repository.dart';
import '../currency_det/currency_det.dart';

class CurrencyMain extends StatelessWidget {
  const CurrencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Przegląd walut'),
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
                  child: Text('Błąd: ${state.message}'),
                );
              }
              if (state is CurrencyLoaded) {
                final currencies = state.currencies;
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: currencies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final currency = currencies[index];
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Text(
                                currency.flag,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  currency.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '${currency.rate.toStringAsFixed(2)} PLN',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
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