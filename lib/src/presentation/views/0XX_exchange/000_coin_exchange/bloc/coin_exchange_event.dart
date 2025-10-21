part of 'coin_exchange_bloc.dart';

abstract class CoinExchangeEvent extends Equatable {
  const CoinExchangeEvent();

  @override
  List<Object?> get props => [];
}

/// Obtiene todas las monedas disponibles
class LoadCoins extends CoinExchangeEvent {}

/// Actualiza la moneda que el usuario tiene
class UpdateFromCurrency extends CoinExchangeEvent {
  final CoinModel? currency;

  const UpdateFromCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

/// Actualiza la moneda que el usuario quiere
class UpdateToCurrency extends CoinExchangeEvent {
  final CoinModel? currency;

  const UpdateToCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

/// Intercambia las monedas (TENGO <-> QUIERO)
class SwapCurrencies extends CoinExchangeEvent {}

/// Actualiza el valor de la cantidad a intercambiar
class UpdateAmount extends CoinExchangeEvent {
  final double amount;

  const UpdateAmount(this.amount);

  @override
  List<Object?> get props => [amount];
}

/// Ejecuta el intercambio
class PerformExchange extends CoinExchangeEvent {}

/// Reinicia los valores del exchange a 0.
class ResetExchange extends CoinExchangeEvent {}

/// Resetea el error para mostrar solo 1 vez el Snackbar
class ResetError extends CoinExchangeEvent {}
