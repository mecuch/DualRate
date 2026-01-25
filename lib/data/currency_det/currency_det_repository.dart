import '../currency_det/nbp_det_api.dart';
import 'currency_det_model.dart';

class CurrencyDetailsRepository {
  CurrencyDetailsRepository({NbpDetailsApi? api}) : _api = api ?? NbpDetailsApi();

  final NbpDetailsApi _api;

  Future<CurrencyDetailsModel> fetchDetails({
    required String code,
    required String flag,
    int last = 30,
  }) async {
    final json = await _api.fetchRateHistory(code: code, last: last);
    return CurrencyDetailsModel.fromNbpJson(json: json, flag: flag);
  }
}