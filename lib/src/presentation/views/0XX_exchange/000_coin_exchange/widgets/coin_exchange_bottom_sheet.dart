import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:flutter/material.dart';

class CoinExchangeBottomSheet extends StatelessWidget {
  final List<CoinModel> currencies;
  final CoinModel? selectedCurrency;
  final String title;

  const CoinExchangeBottomSheet({
    super.key,
    required this.currencies,
    required this.selectedCurrency,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.66;

    return SafeArea(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  final currency = currencies[index];
                  final currencyId = currency.coinType == CoinType.crypto
                      ? currency.getShortCryptoName()
                      : currency.fiatCurrencyId ?? '';

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      child: Image.asset(currency.getImage()),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currencyId,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          currency.getName(),
                          style: TextStyle(
                            color: ColorConstants.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context, currency);
                    },
                    trailing: Radio<CoinModel>(
                      value: currency,
                      groupValue: selectedCurrency,
                      activeColor: Colors.black,
                      onChanged: (val) {
                        if (val != null) Navigator.pop(context, val);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
