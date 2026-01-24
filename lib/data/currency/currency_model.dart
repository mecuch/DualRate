class CurrencyModel {
  CurrencyModel({
    required this.code,
    required this.name,
    required this.rate,
    required this.flag,
  });

  final String code;
  final String name;
  final double rate;
  final String flag;

  factory CurrencyModel.fromNbpJson(Map<String, dynamic> json) {
    final code = json['code']?.toString() ?? '';
    return CurrencyModel(
      code: code,
      name: json['currency']?.toString() ?? '',
      rate: (json['mid'] as num?)?.toDouble() ?? 0.0,
      flag: _flagForCode(code),
    );
  }

  static String _flagForCode(String code) {
    const flags = {
      'USD': '🇺🇸',
      'EUR': '🇪🇺',
      'GBP': '🇬🇧',
      'CHF': '🇨🇭',
      'JPY': '🇯🇵',
      'PLN': '🇵🇱',
    };
    return flags[code] ?? '🏳️';
  }
}