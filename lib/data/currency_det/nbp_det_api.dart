import 'dart:convert';
import 'dart:io';

class NbpDetailsApi {
  NbpDetailsApi({HttpClient? client}) : _client = client ?? HttpClient();

  final HttpClient _client;

  Future<List<dynamic>> fetchTableA() async {
    final uri = Uri.parse(
      'https://api.nbp.pl/api/exchangerates/tables/A?format=json',
    );
    final request = await _client.getUrl(uri);
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('NBP API error: ${response.statusCode}');
    }
    final body = await response.transform(utf8.decoder).join();
    final decoded = jsonDecode(body) as List<dynamic>;
    if (decoded.isEmpty) {
      return <dynamic>[];
    }
    final table = decoded.first as Map<String, dynamic>;
    return (table['rates'] as List<dynamic>?) ?? <dynamic>[];
  }
  Future<Map<String, dynamic>> fetchRateHistory({
    required String code,
    int last = 30,
  }) async {
    final normalizedCode = code.toUpperCase();
    final uri = Uri.parse(
      'https://api.nbp.pl/api/exchangerates/rates/A/$normalizedCode/last/$last?format=json',
    );
    final request = await _client.getUrl(uri);
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('NBP API error: ${response.statusCode}');
    }
    final body = await response.transform(utf8.decoder).join();
    return (jsonDecode(body) as Map<String, dynamic>?) ??
        <String, dynamic>{};
  }
}