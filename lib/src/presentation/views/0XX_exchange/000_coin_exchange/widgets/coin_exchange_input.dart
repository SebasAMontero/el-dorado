import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinExchangeInput extends StatelessWidget {
  final String value;
  final String currency;
  final ValueChanged<String> onChanged;

  const CoinExchangeInput({
    super.key,
    required this.value,
    required this.currency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);

    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
      ],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            currency,
            style: TextStyle(
              color: ColorConstants.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ColorConstants.primary,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorConstants.primary, width: 2),
        ),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}
