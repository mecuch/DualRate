import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/currency_det/currency_det_repository.dart';
import 'currency_det_event.dart';
import 'currency_det_state.dart';

class CurrencyDetailsBloc
    extends Bloc<CurrencyDetailsEvent, CurrencyDetailsState> {
  CurrencyDetailsBloc({required CurrencyDetailsRepository repository})
      : _repository = repository,
        super(const CurrencyDetailsInitial()) {
    on<CurrencyDetailsRequested>(_onRequested);
  }

  final CurrencyDetailsRepository _repository;

  Future<void> _onRequested(
      CurrencyDetailsRequested event,
      Emitter<CurrencyDetailsState> emit,
      ) async {
    emit(const CurrencyDetailsLoading());
    try {
      final details = await _repository.fetchDetails(
        code: event.code,
        flag: event.flag,
        last: event.last,
      );
      emit(CurrencyDetailsLoaded(details));
    } catch (error) {
      emit(CurrencyDetailsFailure(error.toString()));
    }
  }
}