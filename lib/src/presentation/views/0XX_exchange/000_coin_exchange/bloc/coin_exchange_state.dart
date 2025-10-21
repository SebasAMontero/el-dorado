part of 'coin_exchange_bloc.dart';

class CoinExchangeState extends Equatable {
  final List<CoinModel> coins;
  final List<CoinModel> fiatCoins;
  final List<CoinModel> cryptoCoins;
  final bool isLoading;
  final bool hasError;

  final CoinModel? fromCurrency;
  final CoinModel? toCurrency;
  final double amount;
  final double rate;
  final double exchangeTotalToReceive;
  //? Const 10mins se supone que no cambia.
  final int estimatedTime;
  final bool isLoadingExchange;
  final CurrencyExchange? currencyExchange;

  const CoinExchangeState({
    this.isLoading = false,
    this.hasError = false,

    this.coins = const [],
    this.fiatCoins = const [],
    this.cryptoCoins = const [],
    this.fromCurrency,
    this.toCurrency,
    this.amount = 0.0,
    this.rate = 0.0,
    this.exchangeTotalToReceive = 0.0,
    this.estimatedTime = 10,
    this.isLoadingExchange = false,
    this.currencyExchange,
  });

  CoinExchangeState copyWith({
    List<CoinModel>? coins,
    List<CoinModel>? fiatCoins,
    List<CoinModel>? cryptoCoins,
    bool? isLoading,
    bool? hasError,

    CoinModel? fromCurrency,
    CoinModel? toCurrency,
    double? amount,
    double? rate,
    double? exchangeTotalToReceive,
    int? estimatedTime,
    bool? isLoadingExchange,
    CurrencyExchange? currencyExchange,
  }) {
    return CoinExchangeState(
      coins: coins ?? this.coins,
      fiatCoins: fiatCoins ?? this.fiatCoins,
      cryptoCoins: cryptoCoins ?? this.cryptoCoins,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,

      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      rate: rate ?? this.rate,
      exchangeTotalToReceive:
          exchangeTotalToReceive ?? this.exchangeTotalToReceive,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      isLoadingExchange: isLoadingExchange ?? this.isLoadingExchange,
      currencyExchange: currencyExchange ?? this.currencyExchange,
    );
  }

  @override
  List<Object?> get props => [
    coins,
    fiatCoins,
    cryptoCoins,
    isLoading,
    hasError,
    fromCurrency,
    toCurrency,
    amount,
    rate,
    exchangeTotalToReceive,
    estimatedTime,
    isLoadingExchange,
    currencyExchange,
  ];
}
