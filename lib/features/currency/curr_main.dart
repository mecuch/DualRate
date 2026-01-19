import 'package:flutter/material.dart';

class CurrencyMain extends StatelessWidget {
  const CurrencyMain({super.key});

  @override
  Widget build(BuildContext context) {
    final currencies = <Map<String, String>>[
      {'code': 'USD', 'name': 'US Dollar', 'rate': '4.02 PLN'},
      {'code': 'EUR', 'name': 'Euro', 'rate': '4.35 PLN'},
      {'code': 'GBP', 'name': 'British Pound', 'rate': '5.03 PLN'},
      {'code': 'CHF', 'name': 'Swiss Franc', 'rate': '4.48 PLN'},
      {'code': 'JPY', 'name': 'Japanese Yen', 'rate': '0.027 PLN'},
      {'code': 'PLN', 'name': 'Polish Złoty', 'rate': '1.00 PLN'},
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Przegląd walut'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: currencies.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final currency = currencies[index];
            return Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(currency['code'] ?? ''),
                ),
                title: Text(currency['name'] ?? ''),
                subtitle: Text('Kurs: ${currency['rate']}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            );
          },
    )
    );
  }
}