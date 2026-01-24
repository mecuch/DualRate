import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/currency/currency_repository.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc({required CurrencyRepository repository})
      : _repository = repository,
        super(const CurrencyInitial()) {
    on<CurrencyRequested>(_onRequested);
  }

  final CurrencyRepository _repository;

  Future<void> _onRequested(
      CurrencyRequested event,
      Emitter<CurrencyState> emit,
      ) async {
    emit(const CurrencyLoading());
    try {
      final currencies = await _repository.fetchCurrencies();
      emit(CurrencyLoaded(currencies));
    } catch (error) {
      emit(CurrencyFailure(error.toString()));
    }
  }
}