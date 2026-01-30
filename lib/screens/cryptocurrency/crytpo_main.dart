import 'package:dualrate/screens/cryptocurrency_det/crypto_det.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/crypto/crypto_bloc.dart';
import '../../blocs/crypto/crypto_event.dart';
import '../../blocs/crypto/crypto_state.dart';
import '../../data/crypto/crypto_repository.dart';
import '../utils/colors.dart';
import '../utils/widgets.dart';


class CryptoCurrencyMain extends StatelessWidget {
  const CryptoCurrencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorLoader.main_green,
        appBar: AppBar(
            title: const SmallText(text: "Cryptocurrency Overwiew"),
            backgroundColor: Colors.black,
            foregroundColor: ColorLoader.main_green,
            elevation: 4,
            centerTitle: true
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
                            CircleAvatar(
                              backgroundColor: ColorLoader.main_green,
                              child: VerySmallTextWhite(text: crypto.symbol),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: VerySmallTextWhite(text: crypto.name)
                            ),
                            VerySmallTextWhite(text: '${crypto.pricePln.toStringAsFixed(2)} PLN')
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