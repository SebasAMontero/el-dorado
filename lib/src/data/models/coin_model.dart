import 'package:el_dorado/src/data/models/coin_type_enum.dart';

class CoinModel {
  final int? id;
  final CoinType? coinType;
  final String? cryptoCurrencyId;
  final String? fiatCurrencyId;
  final double? amount;
  final String? amountCurrencyId;

  const CoinModel({
    this.id,
    this.coinType,
    this.cryptoCurrencyId,
    this.fiatCurrencyId,
    this.amount,
    this.amountCurrencyId,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'] as int?,
      coinType: json['coinType'] != null
          ? CoinType.fromInt(json['coinType'])
          : null,
      cryptoCurrencyId: json['cryptoCurrencyId'] as String?,
      fiatCurrencyId: json['fiatCurrencyId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      amountCurrencyId: json['amountCurrencyId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coinType': coinType?.toInt(),
      'cryptoCurrencyId': cryptoCurrencyId,
      'fiatCurrencyId': fiatCurrencyId,
      'amount': amount,
      'amountCurrencyId': amountCurrencyId,
    };
  }

  CoinModel copyWith({
    int? id,
    CoinType? coinType,
    String? cryptoCurrencyId,
    String? fiatCurrencyId,
    double? amount,
    String? amountCurrencyId,
  }) {
    return CoinModel(
      id: id ?? this.id,
      coinType: coinType ?? this.coinType,
      cryptoCurrencyId: cryptoCurrencyId ?? this.cryptoCurrencyId,
      fiatCurrencyId: fiatCurrencyId ?? this.fiatCurrencyId,
      amount: amount ?? this.amount,
      amountCurrencyId: amountCurrencyId ?? this.amountCurrencyId,
    );
  }

  String getName() {
    if (coinType == CoinType.crypto) {
      switch (cryptoCurrencyId) {
        case 'USDT':
          return 'Tether (USDT)';
        case 'USDC':
          return 'USD Coin (USDC)';
        default:
          return cryptoCurrencyId ?? '';
      }
    }
    if (coinType == CoinType.fiat) {
      switch (fiatCurrencyId) {
        case 'VES':
          return 'Bolívares (Bs)';
        case 'COP':
          return r'Pesos Colombianos (COL$)';
        case 'ARS':
          return r'Pesos Argentinos (ARS$)';
        case 'PEN':
          return 'Soles Peruanos (S/)';
        case 'BRL':
          return 'Real Brasileño (RS)';
        case 'BOB':
          return r'Boliviano (R$)';
        default:
          return fiatCurrencyId ?? '';
      }
    }
    return '';
  }

  String getImage() {
    if (coinType == CoinType.crypto) {
      switch (cryptoCurrencyId) {
        case 'USDT':
          return 'assets/images/cripto_currencies/usdt.png';
        // case 'USDC':
        //   return 'assets/images/cripto_currencies/tatum_tron_.png';
        default:
          return 'assets/images/el_dorado.png';
      }
    }

    if (coinType == CoinType.fiat) {
      switch (fiatCurrencyId) {
        case 'VES':
          return 'assets/images/fiat_currencies/ves.png';
        case 'COP':
          return 'assets/images/fiat_currencies/cop.png';
        // case 'ARS':
        //   return 'assets/images/fiat_currencies/ar.png';
        case 'PEN':
          return 'assets/images/fiat_currencies/pen.png';
        case 'BRL':
          return 'assets/images/fiat_currencies/brl.png';
        // case 'BOB':
        //   return 'assets/images/fiat_currencies/bo.png';
        default:
          return 'assets/images/el_dorado.png';
      }
    }

    return 'assets/images/el_dorado.png';
  }
}
