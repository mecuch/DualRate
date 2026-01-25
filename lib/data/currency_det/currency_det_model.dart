class CurrencyHistoryPoint {
  const CurrencyHistoryPoint({
    required this.effectiveDate,
    required this.mid,
  });

  final DateTime effectiveDate;
  final double mid;

  factory CurrencyHistoryPoint.fromNbpJson(Map<String, dynamic> json) {
    final dateText = json['effectiveDate']?.toString() ?? '';
    final parsedDate = DateTime.tryParse(dateText);
    return CurrencyHistoryPoint(
      effectiveDate: parsedDate ?? DateTime.fromMillisecondsSinceEpoch(0),
      mid: (json['mid'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CurrencyDetailsModel {
  CurrencyDetailsModel({
    required this.code,
    required this.name,
    required this.flag,
    required this.table,
    required this.history,
  });

  final String code;
  final String name;
  final String flag;
  final String table;
  final List<CurrencyHistoryPoint> history;

  CurrencyHistoryPoint get latest => history.last;

  CurrencyHistoryPoint? get previous =>
      history.length > 1 ? history[history.length - 2] : null;

  double get change => previous == null ? 0.0 : latest.mid - previous!.mid;

  double get changePercent {
    final prev = previous;
    if (prev == null || prev.mid == 0) {
      return 0.0;
    }
    return ((latest.mid / prev.mid) - 1) * 100;
  }

  double get minMid =>
      history.map((point) => point.mid).reduce((a, b) => a < b ? a : b);

  double get maxMid =>
      history.map((point) => point.mid).reduce((a, b) => a > b ? a : b);

  int get daysRange => history.length;

  DateTime get lastUpdated => latest.effectiveDate;

  factory CurrencyDetailsModel.fromNbpJson({
    required Map<String, dynamic> json,
    required String flag,
  }) {
    final rates = (json['rates'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(CurrencyHistoryPoint.fromNbpJson)
        .toList()
      ..sort((a, b) => a.effectiveDate.compareTo(b.effectiveDate));

    if (rates.isEmpty) {
      throw Exception('Brak danych historycznych dla waluty ${json['code']}');
    }

    return CurrencyDetailsModel(
      code: json['code']?.toString() ?? '',
      name: json['currency']?.toString() ?? '',
      flag: flag,
      table: json['table']?.toString() ?? 'A',
      history: rates,
    );
  }
}