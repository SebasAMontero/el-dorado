class ExchangeRequest {
  final int type;
  final String cryptoCurrencyId;
  final String fiatCurrencyId;
  final double amount;
  final String amountCurrencyId;

  const ExchangeRequest({
    required this.type,
    required this.cryptoCurrencyId,
    required this.fiatCurrencyId,
    required this.amount,
    required this.amountCurrencyId,
  });

  factory ExchangeRequest.fromJson(Map<String, dynamic> json) {
    return ExchangeRequest(
      type: json['type'] as int,
      cryptoCurrencyId: json['cryptoCurrencyId'] as String,
      fiatCurrencyId: json['fiatCurrencyId'] as String,
      amount: (json['amount'] as num).toDouble(),
      amountCurrencyId: json['amountCurrencyId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'cryptoCurrencyId': cryptoCurrencyId,
      'fiatCurrencyId': fiatCurrencyId,
      'amount': amount,
      'amountCurrencyId': amountCurrencyId,
    };
  }

  ExchangeRequest copyWith({
    int? type,
    String? cryptoCurrencyId,
    String? fiatCurrencyId,
    double? amount,
    String? amountCurrencyId,
  }) {
    return ExchangeRequest(
      type: type ?? this.type,
      cryptoCurrencyId: cryptoCurrencyId ?? this.cryptoCurrencyId,
      fiatCurrencyId: fiatCurrencyId ?? this.fiatCurrencyId,
      amount: amount ?? this.amount,
      amountCurrencyId: amountCurrencyId ?? this.amountCurrencyId,
    );
  }
}
