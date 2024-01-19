import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/data/api/currency_api.dart';
import 'package:trading_diary/domain/model/currencies_rate_response.dart';
import 'package:trading_diary/domain/model/currency_symbols.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyApi _api;

  CurrencyBloc(this._api) : super(CurrencyInitialState()) {
    // Когда у тебя в блоке много ивентов, можно оформить их таким образом для наглядности
    on<GetCurrenciesSymbolsEvent>(
      (event, emit) async {
        await _buildCurrencySymbols(event, emit);
      },
    );
    on<GetGurrencyRatesEvent>(
      (event, emit) async {
        await _buildCurrencyRates(event, emit);
      },
    );
  }

  // Запрос списка валют с их символами
  Future<void> _buildCurrencySymbols(
    GetCurrenciesSymbolsEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoadingState());
    // Это важно! Оформление блока try/catch позволяет тебе отлавливать ЛЮБЫЕ ошибки и эмитить их в ErrorState
    try {
      final response = await _api.getCurrencySymbols();
      if (response != null && response.success == true) {
        emit(
          CurrencySymbolsData(
            response,
          ),
        );
      } else {
        emit(
          const CurrencyErrorState(
            'Something went wrong',
          ),
        );
      }
    } catch (e) {
      emit(
        CurrencyErrorState(
          e.toString(),
        ),
      );
    }
  }

  // Запрос курса валют по выбранной паре
  Future<void> _buildCurrencyRates(
    GetGurrencyRatesEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoadingState());
    try {
      final response = await _api.getCurrenciesRate();
      if (response != null && response.success == true) {
        emit(
          CurrencyRateData(
            response,
          ),
        );
      } else {
        emit(
          const CurrencyErrorState(
            'Something went wrong',
          ),
        );
      }
    } catch (e) {
      emit(
        CurrencyErrorState(
          e.toString(),
        ),
      );
    }
  }
}
