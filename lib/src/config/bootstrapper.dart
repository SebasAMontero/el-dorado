import 'package:el_dorado/src/data/datasource/remote_coin_data_source.dart';
import 'package:el_dorado/src/data/repositories/coin_repository_impl.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/bloc/coin_exchange_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bootstrapper {
  static List<BlocProvider> initBlocs() {
    final remoteCoinDataSource = RemoteCoinDataSource();

    final coinRepository = CoinRepositoryImpl(
      remoteCoinDataSource: remoteCoinDataSource,
    );

    return [
      BlocProvider<CoinExchangeBloc>(
        create: (_) =>
            CoinExchangeBloc(coinRepository: coinRepository)..add(LoadCoins()),
      ),
    ];
  }
}
