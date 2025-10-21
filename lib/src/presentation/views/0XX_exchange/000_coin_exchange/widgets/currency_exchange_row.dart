import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_bottom_sheet.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/currency_selector.dart';
import 'package:flutter/material.dart';

class CurrencyExchangeRow extends StatelessWidget {
  final CoinModel? fromCurrency;
  final CoinModel? toCurrency;
  final List<CoinModel> cryptoCoins;
  final List<CoinModel> fiatCoins;
  final Function(CoinModel) onFromSelected;
  final Function(CoinModel) onToSelected;
  final VoidCallback onSwap;

  const CurrencyExchangeRow({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.cryptoCoins,
    required this.fiatCoins,
    required this.onFromSelected,
    required this.onToSelected,
    required this.onSwap,
  });

  Future<CoinModel?> _showCurrencyBottomSheet({
    required BuildContext context,
    required List<CoinModel> currencies,
    required CoinModel? selectedCurrency,
    required String title,
  }) {
    return showModalBottomSheet<CoinModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CoinExchangeBottomSheet(
        currencies: currencies,
        selectedCurrency: selectedCurrency,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: ColorConstants.primary, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: -22,
                      left: 20,

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          StringConstants.exchangeHave,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    CurrencySelector(
                      selectedCurrency: fromCurrency,
                      onTap: () async {
                        final selected = await _showCurrencyBottomSheet(
                          context: context,
                          currencies: cryptoCoins,
                          selectedCurrency: fromCurrency,
                          title: StringConstants.exchangeCryptoTitle,
                        );
                        if (selected != null) onFromSelected(selected);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 56),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: -22,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          StringConstants.exchangeWant,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    CurrencySelector(
                      selectedCurrency: toCurrency,
                      onTap: () async {
                        final selected = await _showCurrencyBottomSheet(
                          context: context,
                          currencies: fiatCoins,
                          selectedCurrency: toCurrency,
                          title: StringConstants.exchangeFiatTitle,
                        );
                        if (selected != null) onToSelected(selected);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: ColorConstants.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.swap_horiz, color: Colors.white),
              onPressed: onSwap,
            ),
          ),
        ),
      ],
    );
  }
}
