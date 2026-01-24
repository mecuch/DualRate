import '../../data/crypto/crypto_model.dart';

abstract class CryptoState {
  const CryptoState();
}

class CryptoInitial extends CryptoState {
  const CryptoInitial();
}

class CryptoLoading extends CryptoState {
  const CryptoLoading();
}

class CryptoLoaded extends CryptoState {
  const CryptoLoaded(this.cryptos);

  final List<CryptoModel> cryptos;
}

class CryptoFailure extends CryptoState {
  const CryptoFailure(this.message);

  final String message;
}