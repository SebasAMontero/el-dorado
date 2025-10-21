import 'dart:convert';

import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:el_dorado/src/data/models/exchange_model.dart';
import 'package:el_dorado/src/data/models/exchange_request_model.dart';
import 'package:http/http.dart' as http;

class RemoteCoinDataSource {
  final http.Client client;

  RemoteCoinDataSource({http.Client? client})
    : client = client ?? http.Client();

  /// Fetches coin exchange
  Future<CurrencyExchange> fetchCoinExchange({
    required ExchangeRequest exchangeRequest,
  }) async {
    final baseUri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.endpointCoins}',
    );

    final uri = baseUri.replace(
      queryParameters: {
        'type': exchangeRequest.type.toString(),
        'cryptoCurrencyId': exchangeRequest.cryptoCurrencyId,
        'fiatCurrencyId': exchangeRequest.fiatCurrencyId,
        'amount': exchangeRequest.amount.toString(),
        'amountCurrencyId': exchangeRequest.amountCurrencyId,
      },
    );
    final response = await client.get(
      uri,

      headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp'},
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return CurrencyExchange.fromJson(jsonBody);
    } else {
      throw Exception('Error fetching coins: ${response.statusCode}');
    }
  }

  /// Fetches coin exchange
  Future<List<CoinModel>> getAllCoins() async {
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

      CoinModel(
        id: 7,
        coinType: CoinType.crypto,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
      ),
      CoinModel(
        id: 8,
        coinType: CoinType.crypto,
        cryptoCurrencyId: 'TATUM-TRON-USDC',
      ),
    ];
    return allCoins;
  }
}
