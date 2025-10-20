enum CoinType {
  fiat,
  crypto;

  static CoinType fromInt(int value) {
    switch (value) {
      case 0:
        return CoinType.crypto;
      case 1:
        return CoinType.fiat;
      default:
        return CoinType.crypto;
    }
  }

  int toInt() {
    switch (this) {
      case CoinType.crypto:
        return 0;
      case CoinType.fiat:
        return 1;
    }
  }
}
