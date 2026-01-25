class CryptoDetailsModel {
  CryptoDetailsModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.rank,
    required this.pricePln,
    required this.priceUsd,
    required this.marketCapPln,
    required this.volume24hPln,
    required this.change24hPercent,
    required this.athPln,
    required this.athDate,
    required this.lastUpdated,
  });

  final String id;
  final String symbol;
  final String name;
  final int rank;
  final double pricePln;
  final double priceUsd;
  final double marketCapPln;
  final double volume24hPln;
  final double change24hPercent;
  final double athPln;
  final DateTime? athDate;
  final DateTime? lastUpdated;

  factory CryptoDetailsModel.fromCoinPaprikaJson(Map<String, dynamic> json) {
    final quotes = json['quotes'] as Map<String, dynamic>? ?? {};
    final pln = quotes['PLN'] as Map<String, dynamic>? ?? {};
    final usd = quotes['USD'] as Map<String, dynamic>? ?? {};

    DateTime? parseDate(dynamic value) {
      final text = value?.toString();
      if (text == null || text.isEmpty) {
        return null;
      }
      return DateTime.tryParse(text);
    }

    return CryptoDetailsModel(
      id: json['id']?.toString() ?? '',
      symbol: json['symbol']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      pricePln: (pln['price'] as num?)?.toDouble() ?? 0.0,
      priceUsd: (usd['price'] as num?)?.toDouble() ?? 0.0,
      marketCapPln: (pln['market_cap'] as num?)?.toDouble() ?? 0.0,
      volume24hPln: (pln['volume_24h'] as num?)?.toDouble() ?? 0.0,
      change24hPercent: (pln['percent_change_24h'] as num?)?.toDouble() ?? 0.0,
      athPln: (pln['ath_price'] as num?)?.toDouble() ?? 0.0,
      athDate: parseDate(pln['ath_date']),
      lastUpdated: parseDate(json['last_updated']),
    );
  }
}