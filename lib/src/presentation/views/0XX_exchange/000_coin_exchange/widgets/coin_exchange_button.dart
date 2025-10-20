import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:flutter/material.dart';

class CoinExchangeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CoinExchangeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: DimensionsConstants.fontMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
