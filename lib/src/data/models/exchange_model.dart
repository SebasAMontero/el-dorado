class CurrencyExchange {
  final String fiatToCryptoExchangeRate;

  const CurrencyExchange({required this.fiatToCryptoExchangeRate});

  factory CurrencyExchange.fromJson(Map<String, dynamic> json) {
    return CurrencyExchange(
      fiatToCryptoExchangeRate:
          json['data']?['byPrice']?['fiatToCryptoExchangeRate'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
    'fiatToCryptoExchangeRate': fiatToCryptoExchangeRate,
  };
}
