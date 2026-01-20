import 'package:flutter/material.dart';

class CryptoCurrencyMain extends StatelessWidget {
  const CryptoCurrencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    final cryptoCurrencies = <Map<String, String>>[
      {'code': 'BTC', 'name': 'Bitcoin', 'price': '268,000 PLN'},
      {'code': 'ETH', 'name': 'Ethereum', 'price': '14,800 PLN'},
      {'code': 'SOL', 'name': 'Solana', 'price': '680 PLN'},
      {'code': 'ADA', 'name': 'Cardano', 'price': '2.40 PLN'},
      {'code': 'XRP', 'name': 'Ripple', 'price': '2.70 PLN'},
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Przegląd kryptowalut'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cryptoCurrencies.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final crypto = cryptoCurrencies[index];
            return Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(crypto['code'] ?? ''),
                ),
                title: Text(crypto['name'] ?? ''),
                subtitle: Text('Cena: ${crypto['price']}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            );
          },
        )
    );
  }
}