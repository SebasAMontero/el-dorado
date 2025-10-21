import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/bloc/coin_exchange_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            const SizedBox(height: DimensionsConstants.fontSmall),
            Container(
              width: 40,
              height: DimensionsConstants.radiusSmall,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: DimensionsConstants.fontSmall),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: DimensionsConstants.fontLarge,
              ),
            ),
            const SizedBox(height: DimensionsConstants.fontSmall),
            Flexible(
              child: RadioGroup<CoinModel>(
                groupValue: selectedCurrency,
                onChanged: (val) {
                  if (val != null) {
                    context.read<CoinExchangeBloc>().add(ResetExchange());
                    Navigator.pop(context, val);
                  }
                },
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
                        radius: DimensionsConstants.paddingMedium,
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
                              fontSize: DimensionsConstants.fontSmall,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        context.read<CoinExchangeBloc>().add(ResetExchange());
                        Navigator.pop(context, currency);
                      },

                      trailing: Radio<CoinModel>(
                        value: currency,
                        activeColor: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
