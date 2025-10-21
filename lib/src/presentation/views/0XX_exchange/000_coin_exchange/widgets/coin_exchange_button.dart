import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:flutter/material.dart';

class CoinExchangeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CoinExchangeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              DimensionsConstants.radiusMedium,
            ),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            vertical: DimensionsConstants.fontSmall,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: DimensionsConstants.iconSmall,
                width: DimensionsConstants.iconSmall,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
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
