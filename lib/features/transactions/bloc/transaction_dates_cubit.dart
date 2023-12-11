import 'package:bloc/bloc.dart';
import 'package:trading_diary/domain/model/transaction_dates.dart';

class TransactionDatesCubit extends Cubit<TransactionDates> {
  TransactionDates transactionDates = TransactionDates();

  TransactionDatesCubit() : super(TransactionDates());

  void setOpenDate(DateTime? openDate) {
    transactionDates.openDate = openDate;
    emit(transactionDates);
  }

  void setCloseDate(DateTime? closeDate) {
    transactionDates.closeDate = closeDate;
    emit(transactionDates);
  }

  void resetDates() {
    transactionDates.resetDates();
  }

  TransactionDates get dates => state;
}
