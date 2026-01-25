import 'paprika_det_api.dart';
import 'crypto_det_model.dart';

class CryptoDetailsRepository {
  CryptoDetailsRepository({CoinPaprikaDetailsApi? api})
      : _api = api ?? CoinPaprikaDetailsApi();

  final CoinPaprikaDetailsApi _api;

  Future<CryptoDetailsModel> fetchDetails({
    required String coinId,
  }) async {
    final json = await _api.fetchTickerDetails(coinId: coinId);
    return CryptoDetailsModel.fromCoinPaprikaJson(json);
  }
}