import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/exchange_model.dart';
import 'package:el_dorado/src/data/models/exchange_request_model.dart';

abstract class CoinRepository {
  Future<CurrencyExchange> getCoinExchange({
    required ExchangeRequest exchangeRequest,
  });
  Future<List<CoinModel>> getAllCoins();
}
