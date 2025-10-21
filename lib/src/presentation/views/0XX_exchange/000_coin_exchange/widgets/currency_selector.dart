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

  @override
  Widget build(BuildContext context) {
    final coinType = selectedCurrency?.coinType;
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
            coinType == CoinType.crypto
                ? selectedCurrency?.getShortCryptoName() ?? ''
                : selectedCurrency?.fiatCurrencyId ?? '',
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
