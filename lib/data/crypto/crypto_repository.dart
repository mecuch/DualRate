import 'paprika_api.dart';
import 'crypto_model.dart';

class CryptoRepository {
  CryptoRepository({CoinPaprikaApi? api}) : _api = api ?? CoinPaprikaApi();

  final CoinPaprikaApi _api;

  Future<List<CryptoModel>> fetchTopCryptos() async {
    const symbols = ['BTC', 'ETH', 'SOL', 'ADA', 'XRP', 'ICP', 'OMG', 'TRX', 'BCH'
    'UNI', 'NEO', 'FIL', 'EOS' ];
    final tickers = await _api.fetchTickersPln();
    final models = tickers
        .whereType<Map<String, dynamic>>()
        .map(CryptoModel.fromCoinPaprikaJson)
        .toList();
    final bySymbol = {for (final model in models) model.symbol: model};
    return [
      for (final symbol in symbols)
        if (bySymbol[symbol] != null) bySymbol[symbol]!,
    ];
  }
}