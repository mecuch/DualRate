import '../../data/currency/currency_model.dart';

abstract class CurrencyState {
  const CurrencyState();
}

class CurrencyInitial extends CurrencyState {
  const CurrencyInitial();
}

class CurrencyLoading extends CurrencyState {
  const CurrencyLoading();
}

class CurrencyLoaded extends CurrencyState {
  const CurrencyLoaded(this.currencies);

  final List<CurrencyModel> currencies;
}

class CurrencyFailure extends CurrencyState {
  const CurrencyFailure(this.message);

  final String message;
}