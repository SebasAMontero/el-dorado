import 'package:el_dorado/src/core/app_constants/app_constants.dart';
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

  /// Helper method para obtener el nombre de la moneda de origen
  String _getFromCurrencyName(CoinExchangeState state) {
    final fromCurrency = state.cryptoCoins.isNotEmpty
        ? state.fromCurrency ?? state.cryptoCoins.first
        : null;

    return fromCurrency?.coinType == CoinType.crypto
        ? state.fromCurrency?.getShortCryptoName() ?? ''
        : fromCurrency?.fiatCurrencyId ?? '';
  }

  /// Helper method para obtener el nombre de la moneda de destino
  String _getToCurrencyName(CoinExchangeState state) {
    final isCryptoToFiat = state.fromCurrency?.coinType == CoinType.crypto;
    return isCryptoToFiat
        ? state.toCurrency?.fiatCurrencyId ?? ''
        : state.toCurrency?.getShortCryptoName() ?? '';
  }

  /// Helper method para manejar la selección de moneda de origen
  void _handleFromCurrencySelection(BuildContext context, CoinModel coin) {
    context.read<CoinExchangeBloc>().add(UpdateFromCurrency(coin));
  }

  /// Helper method para manejar la selección de moneda de destino
  void _handleToCurrencySelection(BuildContext context, CoinModel coin) {
    context.read<CoinExchangeBloc>().add(UpdateToCurrency(coin));
  }

  /// Helper method para manejar el intercambio de monedas
  void _handleSwapCurrencies(BuildContext context) {
    context.read<CoinExchangeBloc>().add(SwapCurrencies());
  }

  /// Helper method para manejar el cambio de cantidad
  void _handleAmountChange(BuildContext context, String value) {
    final amount = double.tryParse(value) ?? 0.0;
    context.read<CoinExchangeBloc>().add(UpdateAmount(amount));
  }

  /// Helper method para ejecutar el intercambio
  void _handlePerformExchange(BuildContext context) {
    context.read<CoinExchangeBloc>().add(PerformExchange());
  }

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
        final fromCurrencyIdName = _getFromCurrencyName(state);
        final toCurrencyIdName = _getToCurrencyName(state);

        return Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(DimensionsConstants.paddingMedium),
              width: DimensionsConstants.containerWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  DimensionsConstants.radiusLarge,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CurrencyExchangeRow(
                    fromCurrency: fromCurrency,
                    toCurrency: toCurrency,
                    cryptoCoins: state.cryptoCoins,
                    fiatCoins: state.fiatCoins,
                    onFromSelected: (coin) =>
                        _handleFromCurrencySelection(context, coin),
                    onToSelected: (coin) =>
                        _handleToCurrencySelection(context, coin),
                    onSwap: () => _handleSwapCurrencies(context),
                  ),
                  const SizedBox(height: DimensionsConstants.paddingMedium),
                  CoinExchangeInput(
                    currency: fromCurrencyIdName,
                    value: state.amount.toString(),
                    onChanged: (val) => _handleAmountChange(context, val),
                  ),
                  const SizedBox(height: 16),
                  ExchangeInfoRow(
                    label: StringConstants.exchangeRate,
                    value:
                        '${StringConstants.approxSymbol}${state.currencyExchange?.fiatToCryptoExchangeRate ?? ''}',
                    suffixText: ' $toCurrencyIdName',
                  ),
                  ExchangeInfoRow(
                    label: StringConstants.exchangeReceive,
                    value:
                        '${StringConstants.approxSymbol}${state.exchangeTotalToReceive.toStringAsFixed(2)}',
                    suffixText: ' $toCurrencyIdName',
                  ),
                  ExchangeInfoRow(
                    label: StringConstants.exchangeEstimatedTime,
                    value:
                        '${StringConstants.approxSymbol}${state.estimatedTime} ',
                  ),
                  const SizedBox(height: DimensionsConstants.paddingMedium),
                  CoinExchangeButton(
                    isLoading: state.isLoadingExchange,
                    text: StringConstants.exchangeButtonText,
                    onPressed: () => _handlePerformExchange(context),
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
