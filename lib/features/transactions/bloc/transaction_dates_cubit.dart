import 'package:bloc/bloc.dart';
import 'package:trading_diary/domain/model/transaction_dates.dart';

class TransactionDatesCubit extends Cubit<TransactionDates> {
  TransactionDates transactionDates =
      TransactionDates(openDate: DateTime(1970));

  TransactionDatesCubit() : super(TransactionDates(openDate: DateTime(1970)));

  void setOpenDate(DateTime openDate) {
    transactionDates.openDate = openDate;
    emit(transactionDates);
  }

  void setCloseDate(DateTime? closeDate) {
    transactionDates.closeDate = closeDate;
    emit(transactionDates);
  }

  TransactionDates get dates => state;
}
