import 'package:el_dorado/src/data/models/coin_model.dart';
import 'package:el_dorado/src/data/models/coin_type_enum.dart';
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
    on<PerformExchange>(_performExchange);
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

      emit(
        state.copyWith(
          isLoading: false,
          coins: coins,
          cryptoCoins: cryptoCoins,
          fiatCoins: fiatCoins,
          fromCurrency: cryptoCoins.isNotEmpty ? cryptoCoins.first : null,
          toCurrency: fiatCoins.isNotEmpty ? fiatCoins.first : null,
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
    emit(
      state.copyWith(
        fromCurrency: state.toCurrency,
        toCurrency: state.fromCurrency,
        amount: state.amount,
      ),
    );
  }

  /// Actualiza la cantidad a intercambiar
  void _updateAmount(UpdateAmount event, Emitter<CoinExchangeState> emit) {
    emit(state.copyWith(amount: event.amount));
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

    emit(state.copyWith(isLoadingExchange: true));

    try {
      //!
      // final result = await _coinRepository.performCoinExchange(
      //   fromCurrency: state.fromCurrency!,
      //   toCurrency: state.toCurrency!,
      //   amount: state.amount,
      // );

      emit(
        state.copyWith(
          isLoadingExchange: false,
          //  lastExchangeResult: result,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingExchange: false, hasError: true));
    }
  }
}
