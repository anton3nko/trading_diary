import 'package:bloc/bloc.dart';
import 'package:trading_diary/domain/model/new_transaction.dart';
import 'package:trading_diary/domain/model/strategy.dart';

//Заменил TransactionDatesCubit, т.к. потребовался доступ к объекту
//Strategy во время добавления новой Transaction, для сохранения id
//выбранной стратегии в БД
class NewTransactionCubit extends Cubit<NewTransaction> {
  final NewTransaction _newTransaction = NewTransaction();

  NewTransactionCubit() : super(NewTransaction());

  void setOpenDate(DateTime? openDate) {
    _newTransaction.openDate = openDate;
    emit(_newTransaction);
  }

  void setCloseDate(DateTime? closeDate) {
    _newTransaction.closeDate = closeDate;
    emit(_newTransaction);
  }

  void setMainStrategy(Strategy strategy) {
    _newTransaction.mainStrategy = strategy;
    emit(_newTransaction);
  }

  void setSecStrategy(Strategy strategy) {
    _newTransaction.secondaryStrategy = strategy;
    emit(_newTransaction);
  }

  void resetNewTransaction() {
    _newTransaction.resetNewTransaction();
  }

  NewTransaction get newTransaction => state;
}
