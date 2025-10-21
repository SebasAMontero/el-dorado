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
            radius: 12,
            backgroundColor: Colors.grey.shade200,
            child: selectedCurrency != null
                ? Image.asset(selectedCurrency!.getImage(), fit: BoxFit.fill)
                : null,
          ),

          const SizedBox(width: 8),

          Text(
            coinType == CoinType.crypto
                ? selectedCurrency?.cryptoCurrencyId ?? ''
                : selectedCurrency?.fiatCurrencyId ?? '',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),

          const Icon(Icons.keyboard_arrow_down, size: 24),
        ],
      ),
    );
  }
}
