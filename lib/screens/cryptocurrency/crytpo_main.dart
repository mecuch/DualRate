import 'package:dualrate/screens/cryptocurrency_det/crypto_det.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/crypto/crypto_bloc.dart';
import '../../blocs/crypto/crypto_event.dart';
import '../../blocs/crypto/crypto_state.dart';
import '../../data/crypto/crypto_repository.dart';


class CryptoCurrencyMain extends StatelessWidget {
  const CryptoCurrencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Przegląd kryptowalut'),
        ),
        body: BlocProvider(
          create: (_) => CryptoBloc(
            repository: CryptoRepository(),
          )..add(const CryptoRequested()),
          child: BlocBuilder<CryptoBloc, CryptoState>(
            builder: (context, state) {
              if (state is CryptoLoading || state is CryptoInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CryptoFailure) {
                return Center(
                  child: Text('Błąd: ${state.message}'),
                );
              }
              if (state is CryptoLoaded) {
                final cryptos = state.cryptos;
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cryptos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final crypto = cryptos[index];
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
                              CircleAvatar(
                                child: Text(crypto.symbol),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  crypto.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '${crypto.pricePln.toStringAsFixed(2)} PLN',
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
                                builder: (context) => CryptoCurrencyDetails(cryptoName: crypto.name, coinId: crypto.id),
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
        )
    );
  }
}