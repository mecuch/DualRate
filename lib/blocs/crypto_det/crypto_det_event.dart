abstract class CryptoDetailsEvent {
  const CryptoDetailsEvent();
}

class CryptoDetailsRequested extends CryptoDetailsEvent {
  const CryptoDetailsRequested(this.coinID);

  final String coinID;
}