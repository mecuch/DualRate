import 'currency_model.dart';
import 'nbp_api.dart';

class CurrencyRepository {
  CurrencyRepository({NbpApi? api}) : _api = api ?? NbpApi();

  final NbpApi _api;

  Future<List<CurrencyModel>> fetchCurrencies() async {
    final rates = await _api.fetchTableA();
    return rates
        .whereType<Map<String, dynamic>>()
        .map(CurrencyModel.fromNbpJson)
        .toList();
  }
}