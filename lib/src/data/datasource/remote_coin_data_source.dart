import 'dart:convert';

import 'package:el_dorado/src/core/app_constants/api_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:http/http.dart' as http;

class RemoteCoinDataSource {
  final http.Client client;

  RemoteCoinDataSource({http.Client? client})
    : client = client ?? http.Client();

  /// Fetches coin exchange
  Future<List<CoinModel>> fetchCoinExchange({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await client.get(
      Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.endpointCoins}?_page=$page&_limit=$limit',
      ),
      headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp'},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => CoinModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching coins: ${response.statusCode}');
    }
  }

  /// Fetches coin exchange
  Future<List<CoinModel>> getAllCoins({int page = 1, int limit = 10}) async {
    //? Fetch coins from service
    // if (  response.statusCode == 200) {
    //      } else {
    //   throw Exception('Error fetching coins: ${response.statusCode}');
    // }

    final allCoins = [
      CoinModel(id: 1, coinType: CoinType.fiat, fiatCurrencyId: 'VES'),
      CoinModel(id: 2, coinType: CoinType.fiat, fiatCurrencyId: 'COP'),
      CoinModel(id: 3, coinType: CoinType.fiat, fiatCurrencyId: 'ARS'),
      CoinModel(id: 4, coinType: CoinType.fiat, fiatCurrencyId: 'PEN'),
      CoinModel(id: 5, coinType: CoinType.fiat, fiatCurrencyId: 'BRL'),
      CoinModel(id: 6, coinType: CoinType.fiat, fiatCurrencyId: 'BOB'),

      CoinModel(id: 7, coinType: CoinType.crypto, cryptoCurrencyId: 'USDT'),
      CoinModel(id: 8, coinType: CoinType.crypto, cryptoCurrencyId: 'USDC'),
    ];
    return allCoins;
  }

  Future<double> fetchExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    final uri =
        Uri.parse(
          'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations',
        ).replace(
          queryParameters: {
            'type': type.toString(),
            'cryptoCurrencyId': cryptoCurrencyId,
            'fiatCurrencyId': fiatCurrencyId,
            'amount': amount.toString(),
            'amountCurrencyId': amountCurrencyId,
          },
        );

    final response = await client.get(
      uri,
      headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      final rate = jsonData['data']?['byPrice']?['fiatToCryptoExchangeRate'];
      if (rate == null) throw Exception('Exchange rate not found in response');
      return (rate as num).toDouble();
    } else {
      throw Exception('Error fetching exchange rate: ${response.statusCode}');
    }
  }
}
