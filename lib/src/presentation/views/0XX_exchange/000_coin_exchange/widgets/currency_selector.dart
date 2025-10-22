import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final CoinModel? selectedCurrency;
  final VoidCallback onTap;

  const CurrencySelector({
    super.key,
    required this.selectedCurrency,
    required this.onTap,
  });

  /// Helper method para obtener el nombre de la moneda
  String _getCurrencyName() {
    final coinType = selectedCurrency?.coinType;
    return coinType == CoinType.crypto
        ? selectedCurrency?.getShortCryptoName() ?? ''
        : selectedCurrency?.fiatCurrencyId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: DimensionsConstants.fontSmall,
            backgroundColor: Colors.grey.shade200,
            child: selectedCurrency != null
                ? Image.asset(selectedCurrency!.getImage(), fit: BoxFit.fill)
                : null,
          ),
          const SizedBox(width: DimensionsConstants.paddingSmall),
          Text(
            _getCurrencyName(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: DimensionsConstants.fontMedium,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: DimensionsConstants.iconSmall,
          ),
        ],
      ),
    );
  }
}
