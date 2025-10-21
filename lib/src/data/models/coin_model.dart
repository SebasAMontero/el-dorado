import 'package:el_dorado/src/core/app_constants/image_constants.dart';
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

  String getShortCryptoName() {
    switch (cryptoCurrencyId) {
      case 'TATUM-TRON-USDT':
        return 'USDT';
      case 'TATUM-TRON-USDC':
        return 'USDC';
      default:
        return cryptoCurrencyId ?? '';
    }
  }

  String getName() {
    if (coinType == CoinType.crypto) {
      switch (cryptoCurrencyId) {
        case 'TATUM-TRON-USDT':
          return 'Tether (USDT)';
        case 'TATUM-TRON-USDC':
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
        case 'TATUM-TRON-USDT':
          return ImageConstants.usdt;
        case 'TATUM-TRON-USDC':
          return ImageConstants.usdc;
        default:
          return ImageConstants.elDorado;
      }
    }

    if (coinType == CoinType.fiat) {
      switch (fiatCurrencyId) {
        case 'VES':
          return ImageConstants.ves;
        case 'COP':
          return ImageConstants.cop;
        case 'ARS':
          return ImageConstants.arg;
        case 'PEN':
          return ImageConstants.pen;
        case 'BRL':
          return ImageConstants.brl;
        case 'BOB':
          return ImageConstants.bob;
        default:
          return ImageConstants.elDorado;
      }
    }

    return ImageConstants.elDorado;
  }
}
