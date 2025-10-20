import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/bloc/coin_exchange_bloc.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_button.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_info_row.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_input.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinExchangeCard extends StatelessWidget {
  const CoinExchangeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinExchangeBloc, CoinExchangeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        //  else if (state.hasError && state.coins.isEmpty) {
        //   return Center(
        //     child: Text(
        //       StringConstants.errorCoins,
        //       style: const TextStyle(color: Colors.red),
        //     ),
        //   );
        // } else if (state.coins.isEmpty) {
        //   return const Center(child: Text(StringConstants.emptyCoins));
        // }

        return Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCurrencyRow(context, state),
                  const SizedBox(height: 16),
                  CoinExchangeInput(
                    currency: 'USDT',
                    value: state.amount.toString(),
                    onChanged: (val) {
                      context.read<CoinExchangeBloc>().add(
                        UpdateAmount(state.amount),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ExchangeInfoRow(
                    label: 'Tasa estimada',
                    value: '≈ ${state.rate}',
                    suffixText: ' ${state.toCurrency?.cryptoCurrencyId}',
                  ),
                  ExchangeInfoRow(
                    label: 'Recibirás',
                    value: '≈ ${state.receive}',
                    suffixText: ' ${state.toCurrency?.cryptoCurrencyId}',
                  ),
                  ExchangeInfoRow(
                    label: 'Tiempo estimado',
                    value: '≈ ${state.estimatedTime} ',
                  ),
                  const SizedBox(height: 16),
                  CoinExchangeButton(
                    text: 'Cambiar',
                    onPressed: () {
                      context.read<CoinExchangeBloc>().add(PerformExchange());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrencyRow(BuildContext context, CoinExchangeState state) {
    final fiat = state.fiatCoins;
    final crypto = state.cryptoCoins;
    return Row(
      children: [
        Expanded(
          child: CurrencySelector(
            label: 'TENGO',
            selectedCurrency: state.fromCurrency,
            onTap: () async {
              final selected = await showCurrencyBottomSheet(
                context: context,
                currencies: crypto,
                title: 'Cripto',
              );
              if (selected != null && context.mounted) {
                context.read<CoinExchangeBloc>().add(
                  UpdateFromCurrency(selected),
                );
              }
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.primary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {
              context.read<CoinExchangeBloc>().add(SwapCurrencies());
            },
            icon: const Icon(Icons.swap_horiz, color: Colors.white),
          ),
        ),
        Expanded(
          child: CurrencySelector(
            label: 'QUIERO',
            selectedCurrency: state.toCurrency,
            onTap: () async {
              final selected = await showCurrencyBottomSheet(
                context: context,
                currencies: fiat,
                title: 'FIAT',
              );
              if (selected != null && context.mounted) {
                context.read<CoinExchangeBloc>().add(
                  UpdateFromCurrency(selected),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

Future<CoinModel?> showCurrencyBottomSheet({
  required BuildContext context,
  required List<CoinModel> currencies,
  required String title,
}) {
  return showModalBottomSheet<CoinModel>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
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
                      ? currency.cryptoCurrencyId ?? ''
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
                          style: TextStyle(fontWeight: FontWeight.w500),
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
                    trailing: Radio<CoinModel>(value: currency),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
