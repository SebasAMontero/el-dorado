import 'package:el_dorado/src/core/app_constants/string_constants.dart';
import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/bloc/coin_exchange_bloc.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_button.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_info_row.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_input.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/currency_exchange_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinExchangeCard extends StatelessWidget {
  const CoinExchangeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinExchangeBloc, CoinExchangeState>(
      listener: (context, state) {
        if (state.hasError) {
          context.read<CoinExchangeBloc>().add(ResetError());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text(StringConstants.errorCoins)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final fromCurrency = state.cryptoCoins.isNotEmpty
            ? state.fromCurrency ?? state.cryptoCoins.first
            : null;
        final toCurrency = state.fiatCoins.isNotEmpty
            ? state.toCurrency ?? state.fiatCoins.first
            : null;
        final fromCurrencyIdName = fromCurrency?.coinType == CoinType.crypto
            ? state.fromCurrency?.getShortCryptoName() ?? ''
            : fromCurrency?.fiatCurrencyId ?? '';
        final isCryptoToFiat = state.fromCurrency?.coinType == CoinType.crypto;

        final cryptoCurrencyId = isCryptoToFiat
            ? state.toCurrency?.fiatCurrencyId ?? ''
            : state.toCurrency?.getShortCryptoName() ?? '';

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
                  CurrencyExchangeRow(
                    fromCurrency: fromCurrency,
                    toCurrency: toCurrency,
                    cryptoCoins: state.cryptoCoins,
                    fiatCoins: state.fiatCoins,
                    onFromSelected: (CoinModel coin) {
                      context.read<CoinExchangeBloc>().add(
                        UpdateFromCurrency(coin),
                      );
                    },
                    onToSelected: (CoinModel coin) {
                      context.read<CoinExchangeBloc>().add(
                        UpdateToCurrency(coin),
                      );
                    },
                    onSwap: () {
                      context.read<CoinExchangeBloc>().add(SwapCurrencies());
                    },
                  ),
                  const SizedBox(height: 16),
                  CoinExchangeInput(
                    currency: fromCurrencyIdName,
                    value: state.amount.toString(),
                    onChanged: (val) {
                      final amount = double.tryParse(val) ?? 0.0;
                      context.read<CoinExchangeBloc>().add(
                        UpdateAmount(amount),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ExchangeInfoRow(
                    label: StringConstants.exchangeRate,
                    value:
                        '${StringConstants.approxSymbol}${state.currencyExchange?.fiatToCryptoExchangeRate ?? ''}',
                    suffixText: ' $cryptoCurrencyId',
                  ),
                  ExchangeInfoRow(
                    label: StringConstants.exchangeReceive,
                    value:
                        '${StringConstants.approxSymbol}${state.exchangeTotalToReceive.toStringAsFixed(2)}',
                    suffixText: ' $cryptoCurrencyId',
                  ),
                  ExchangeInfoRow(
                    label: StringConstants.exchangeEstimatedTime,
                    value:
                        '${StringConstants.approxSymbol}${state.estimatedTime} ',
                  ),
                  const SizedBox(height: 16),
                  CoinExchangeButton(
                    isLoading: state.isLoadingExchange,
                    text: StringConstants.exchangeButtonText,
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
}
