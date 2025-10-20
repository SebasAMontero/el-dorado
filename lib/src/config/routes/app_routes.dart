import 'package:el_dorado/src/core/app_constants/route_constants.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/coin_exchange_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.home:
      case RouteConstants.coinsExchange:
        return MaterialPageRoute(builder: (_) => const CoinExchangePage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Undefined route'))),
        );
    }
  }
}
