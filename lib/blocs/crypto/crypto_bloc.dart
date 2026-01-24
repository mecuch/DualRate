import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/crypto/crypto_repository.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc({required CryptoRepository repository})
      : _repository = repository,
        super(const CryptoInitial()) {
    on<CryptoRequested>(_onRequested);
  }

  final CryptoRepository _repository;

  Future<void> _onRequested(
      CryptoRequested event,
      Emitter<CryptoState> emit,
      ) async {
    emit(const CryptoLoading());
    try {
      final cryptos = await _repository.fetchTopCryptos();
      emit(CryptoLoaded(cryptos));
    } catch (error) {
      emit(CryptoFailure(error.toString()));
    }
  }
}