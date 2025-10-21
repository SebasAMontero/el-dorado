import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:flutter/material.dart';

class ExchangeInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String suffixText;

  const ExchangeInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.suffixText = 'Min',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: ColorConstants.textSecondary),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),

              Text(suffixText),
            ],
          ),
        ],
      ),
    );
  }
}
