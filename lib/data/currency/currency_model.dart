import 'dart:ui';

import 'package:dualrate/screens/utils/images.dart';

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
    var flags = {
      'USD': ImageLoader.usa,
      'EUR': ImageLoader.eur,
      'GBP': ImageLoader.gb,
      'CHF': ImageLoader.chf,
      'JPY': ImageLoader.jpy,
      'PLN': ImageLoader.pln,
      'THB': ImageLoader.thb,
      'AUD': ImageLoader.aud,
      'HKD': ImageLoader.hkd,
      'CAD': ImageLoader.cad,
      'SGD': ImageLoader.sgd,
      'HUF': ImageLoader.huf,
      'NZD': ImageLoader.nzd

    };
    return flags[code] ?? 'XXX';
  }
}