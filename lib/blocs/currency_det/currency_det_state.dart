import '../../data/currency_det/currency_det_model.dart';

abstract class CurrencyDetailsState {
  const CurrencyDetailsState();
}

class CurrencyDetailsInitial extends CurrencyDetailsState {
  const CurrencyDetailsInitial();
}

class CurrencyDetailsLoading extends CurrencyDetailsState {
  const CurrencyDetailsLoading();
}

class CurrencyDetailsLoaded extends CurrencyDetailsState {
  const CurrencyDetailsLoaded(this.details);

  final CurrencyDetailsModel details;
}

class CurrencyDetailsFailure extends CurrencyDetailsState {
  const CurrencyDetailsFailure(this.message);

  final String message;
}