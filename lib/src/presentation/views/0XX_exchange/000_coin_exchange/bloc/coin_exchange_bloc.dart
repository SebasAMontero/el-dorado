import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
import 'package:el_dorado/src/data/models/exchange_model.dart';
import 'package:el_dorado/src/data/models/exchange_request_model.dart';
import 'package:el_dorado/src/domain/repositories/coin_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coin_exchange_event.dart';
part 'coin_exchange_state.dart';

class CoinExchangeBloc extends Bloc<CoinExchangeEvent, CoinExchangeState> {
  final CoinRepository _coinRepository;

  CoinExchangeBloc({required CoinRepository coinRepository})
    : _coinRepository = coinRepository,
      super(CoinExchangeState()) {
    on<LoadCoins>(_loadCoins);
    on<UpdateFromCurrency>(_updateFromCurrency);
    on<UpdateToCurrency>(_updateToCurrency);
    on<SwapCurrencies>(_swapCurrencies);
    on<UpdateAmount>(_updateAmount);
    on<ResetError>(_resetError);
    on<PerformExchange>(_performExchange);
  }
  void _resetError(ResetError event, Emitter<CoinExchangeState> emit) {
    emit(state.copyWith(hasError: false, isLoading: false));
  }

  Future<void> _loadCoins(
    LoadCoins event,
    Emitter<CoinExchangeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final coins = await _coinRepository.getAllCoins();

      final cryptoCoins = coins
          .where((c) => c.coinType == CoinType.crypto)
          .toList();
      final fiatCoins = coins
          .where((c) => c.coinType == CoinType.fiat)
          .toList();
      final fromCurrency = cryptoCoins.isNotEmpty ? cryptoCoins.first : null;
      final toCurrency = fiatCoins.isNotEmpty ? fiatCoins.first : null;

      //? Initial data
      final exchangeRequest = ExchangeRequest(
        type: 0,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'VES',
        amount: 0,
        amountCurrencyId: 'VES',
      );
      final currencyExchange = await _coinRepository.getCoinExchange(
        exchangeRequest: exchangeRequest,
      );
      final rate =
          double.tryParse(currencyExchange.fiatToCryptoExchangeRate) ?? 0.0;
      final exchangeTotalToReceive = 200 * rate;

      emit(
        state.copyWith(
          isLoading: false,
          coins: coins,
          cryptoCoins: cryptoCoins,
          fiatCoins: fiatCoins,
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          exchangeTotalToReceive: exchangeTotalToReceive,
          currencyExchange: currencyExchange,
          hasError: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  /// Actualiza la moneda que el usuario tiene
  void _updateFromCurrency(
    UpdateFromCurrency event,
    Emitter<CoinExchangeState> emit,
  ) {
    emit(state.copyWith(fromCurrency: event.currency));
  }

  /// Actualiza la moneda que el usuario quiere
  void _updateToCurrency(
    UpdateToCurrency event,
    Emitter<CoinExchangeState> emit,
  ) {
    emit(state.copyWith(toCurrency: event.currency));
  }

  /// Intercambia las monedas
  void _swapCurrencies(SwapCurrencies event, Emitter<CoinExchangeState> emit) {
    final swappedFrom = state.toCurrency;
    final swappedTo = state.fromCurrency;

    final swappedCryptoCoins = state.fiatCoins;
    final swappedFiatCoins = state.cryptoCoins;

    emit(
      state.copyWith(
        fromCurrency: swappedFrom,
        toCurrency: swappedTo,
        cryptoCoins: swappedCryptoCoins,
        fiatCoins: swappedFiatCoins,
      ),
    );
  }

  /// Actualiza la cantidad a intercambiar
  void _updateAmount(UpdateAmount event, Emitter<CoinExchangeState> emit) {
    emit(state.copyWith(amount: event.amount, hasError: false));
  }

  /// Ejecuta el intercambio
  Future<void> _performExchange(
    PerformExchange event,
    Emitter<CoinExchangeState> emit,
  ) async {
    if (state.amount <= 0 ||
        state.fromCurrency == null ||
        state.toCurrency == null) {
      return;
    }

    emit(state.copyWith(isLoadingExchange: true, hasError: false));

    try {
      final fromCurrency = state.fromCurrency!;
      final toCurrency = state.toCurrency!;
      final amount = state.amount;
      final exchangeRequest = ExchangeRequest(
        type: fromCurrency.coinType == CoinType.crypto ? 0 : 1,
        cryptoCurrencyId: fromCurrency.cryptoCurrencyId ?? '',
        fiatCurrencyId: toCurrency.fiatCurrencyId ?? '',
        amount: amount,
        amountCurrencyId: toCurrency.fiatCurrencyId ?? '',
      );
      final currencyExchange = await _coinRepository.getCoinExchange(
        exchangeRequest: exchangeRequest,
      );
      final rate =
          double.tryParse(currencyExchange.fiatToCryptoExchangeRate) ?? 0.0;
      final exchangeTotalToReceive = 200 * rate;
      emit(
        state.copyWith(
          isLoadingExchange: false,
          exchangeTotalToReceive: exchangeTotalToReceive,
          currencyExchange: currencyExchange,
          hasError: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingExchange: false, hasError: true));
    }
  }
}
