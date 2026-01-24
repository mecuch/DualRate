import 'dart:convert';
import 'dart:io';

class CoinPaprikaApi {
  CoinPaprikaApi({HttpClient? client}) : _client = client ?? HttpClient();

  final HttpClient _client;

  Future<List<dynamic>> fetchTickersPln() async {
    final uri = Uri.parse('https://api.coinpaprika.com/v1/tickers?quotes=PLN');
    final request = await _client.getUrl(uri);
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('CoinPaprika API error: ${response.statusCode}');
    }
    final body = await response.transform(utf8.decoder).join();
    return (jsonDecode(body) as List<dynamic>?) ?? <dynamic>[];
  }
}