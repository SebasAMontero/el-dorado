import 'package:el_dorado/src/data/datasource/remote_coin_data_source.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/exchange_model.dart';
import 'package:el_dorado/src/data/models/exchange_request_model.dart';
import 'package:el_dorado/src/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final RemoteCoinDataSource remoteCoinDataSource;

  CoinRepositoryImpl({required this.remoteCoinDataSource});

  @override
  Future<CurrencyExchange> getCoinExchange({
    required ExchangeRequest exchangeRequest,
  }) {
    return remoteCoinDataSource.fetchCoinExchange(
      exchangeRequest: exchangeRequest,
    );
  }

  @override
  Future<List<CoinModel>> getAllCoins() {
    return remoteCoinDataSource.getAllCoins();
  }
}
