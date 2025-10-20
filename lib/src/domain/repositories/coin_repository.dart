import 'package:el_dorado/src/data/models/coin_model.dart';

abstract class CoinRepository {
  Future<List<CoinModel>> getCoinExchange();
  Future<List<CoinModel>> getAllCoins();
}
