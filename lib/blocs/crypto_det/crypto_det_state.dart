import '../../data/crypto_det/crypto_det_model.dart';

abstract class CryptoDetailsState {
  const CryptoDetailsState();
}

class CryptoDetailsInitial extends CryptoDetailsState {
  const CryptoDetailsInitial();
}

class CryptoDetailsLoading extends CryptoDetailsState {
  const CryptoDetailsLoading();
}

class CryptoDetailsLoaded extends CryptoDetailsState {
  const CryptoDetailsLoaded(this.details);

  final List<CryptoDetailsModel> details;
}

class CryptoDetailsFailure extends CryptoDetailsState {
  const CryptoDetailsFailure(this.message);

  final String message;
}