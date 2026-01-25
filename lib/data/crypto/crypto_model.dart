class CryptoModel {
  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.pricePln,
  });
  final String id;
  final String symbol;
  final String name;
  final double pricePln;

  factory CryptoModel.fromCoinPaprikaJson(Map<String, dynamic> json) {
    final quotes = json['quotes'] as Map<String, dynamic>? ?? {};
    final pln = quotes['PLN'] as Map<String, dynamic>? ?? {};
    return CryptoModel(
      id: json['id']?.toString() ?? '',
      symbol: json['symbol']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      pricePln: (pln['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}