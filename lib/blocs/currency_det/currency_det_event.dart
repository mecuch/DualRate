abstract class CurrencyDetailsEvent {
  const CurrencyDetailsEvent();
}

class CurrencyDetailsRequested extends CurrencyDetailsEvent {
  const CurrencyDetailsRequested({
    required this.code,
    required this.flag,
    this.last = 30,
  });

  final String code;
  final String flag;
  final int last;
}