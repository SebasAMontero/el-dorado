part of 'coin_exchange_bloc.dart';

class CoinExchangeState extends Equatable {
  final List<CoinModel> coins;
  final List<CoinModel> fiatCoins;
  final List<CoinModel> cryptoCoins;
  final bool isLoading;
  final bool hasError;
  final bool hasMore;
  final CoinModel? fromCurrency;
  final CoinModel? toCurrency;
  final double amount;
  final double rate;
  final double receive;
  final int estimatedTime;
  final bool isLoadingExchange;
  final dynamic lastExchangeResult;

  const CoinExchangeState({
    this.isLoading = false,
    this.hasError = false,
    this.hasMore = true,
    this.coins = const [],
    this.fiatCoins = const [],
    this.cryptoCoins = const [],
    this.fromCurrency,
    this.toCurrency,
    this.amount = 0.0,
    this.rate = 0.0,
    this.receive = 0.0,
    this.estimatedTime = 0,
    this.isLoadingExchange = false,
    this.lastExchangeResult,
  });

  CoinExchangeState copyWith({
    List<CoinModel>? coins,
    List<CoinModel>? fiatCoins,
    List<CoinModel>? cryptoCoins,
    bool? isLoading,
    bool? hasError,
    bool? hasMore,
    CoinModel? fromCurrency,
    CoinModel? toCurrency,
    double? amount,
    double? rate,
    double? receive,
    int? estimatedTime,
    bool? isLoadingExchange,
    dynamic lastExchangeResult,
  }) {
    return CoinExchangeState(
      coins: coins ?? this.coins,
      fiatCoins: fiatCoins ?? this.fiatCoins,
      cryptoCoins: cryptoCoins ?? this.cryptoCoins,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      hasMore: hasMore ?? this.hasMore,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      rate: rate ?? this.rate,
      receive: receive ?? this.receive,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      isLoadingExchange: isLoadingExchange ?? this.isLoadingExchange,
      lastExchangeResult: lastExchangeResult ?? this.lastExchangeResult,
    );
  }

  @override
  List<Object?> get props => [
    coins,
    fiatCoins,
    cryptoCoins,
    isLoading,
    hasError,
    hasMore,
    fromCurrency,
    toCurrency,
    amount,
    rate,
    receive,
    estimatedTime,
    isLoadingExchange,
    lastExchangeResult,
  ];
}
