import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final String label;
  final CoinModel? selectedCurrency;
  final VoidCallback onTap;

  const CurrencySelector({
    super.key,
    required this.label,
    required this.selectedCurrency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final coinType = selectedCurrency?.coinType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: selectedCurrency?.getImage() != null
                      ? NetworkImage(selectedCurrency!.getImage())
                      : null,
                  child: selectedCurrency?.getImage() == null
                      ? const Icon(Icons.monetization_on, size: 16)
                      : null,
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    coinType == CoinType.crypto
                        ? selectedCurrency?.cryptoCurrencyId ?? ''
                        : selectedCurrency?.fiatCurrencyId ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),

                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
