import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/crypto_det/crypto_det_repository.dart';
import 'crypto_det_event.dart';
import 'crypto_det_state.dart';

class CryptoDetailsBloc extends Bloc<CryptoDetailsEvent, CryptoDetailsState> {
  CryptoDetailsBloc({required CryptoDetailsRepository repository})
      : _repository = repository,
        super(const CryptoDetailsInitial()) {
    on<CryptoDetailsRequested>(_onRequested);
  }

  final CryptoDetailsRepository _repository;

  Future<void> _onRequested(
      CryptoDetailsRequested event,
      Emitter<CryptoDetailsState> emit,
      ) async {
    emit(const CryptoDetailsLoading());
    try {
      final details = await _repository.fetchDetails(coinId: event.coinID);
      emit(CryptoDetailsLoaded([details]));
    } catch (error) {
      emit(CryptoDetailsFailure(error.toString()));
    }
  }
}