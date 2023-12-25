import 'dart:developer';

//import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/services/database_service.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';

class TransactionsRepo {
  TransactionsRepo._();

  final dbContext = DatabaseService.instance;
  static final TransactionsRepo instance = TransactionsRepo._();

  //Transaction CRUD - методы (create, read, update, delete)
  Future<TradingTransaction> createTransaction(
      TradingTransaction transaction) async {
    final db = await dbContext.database;
    final id = await db.insert(transactionTable, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<TradingTransaction> readTransaction({required int id}) async {
    final db = await dbContext.database;

    final maps = await db.query(
      transactionTable,
      columns: TransactionFields.values,
      where: '${TransactionFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TradingTransaction.fromJson(maps.first);
    } else {
      throw Exception('ID $id was not found');
    }
  }

  Future<List<TradingTransaction>> readAllTransactions() async {
    final db = await dbContext.database;
    const orderBy = '${TransactionFields.id} ASC';
    final result = await db.query(transactionTable, orderBy: orderBy);
    log(result.toString(), name: 'readAllTransactions');
    return result.map((json) => TradingTransaction.fromJson(json)).toList();
  }

  Future<int> updateTransaction(
      {required TradingTransaction transaction}) async {
    final db = await dbContext.database;

    return db.update(
      transactionTable,
      transaction.toJson(),
      where: '${TransactionFields.id} = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction({required int id}) async {
    final db = await dbContext.database;
    final result = await db.delete(
      transactionTable,
      where: '${TransactionFields.id} = ?',
      whereArgs: [id],
    );
    return result;
  }

//   Future<void> calculateTopStrategies() async {
//     final db = await dbContext.database;
//     final allTrByStrat = await db.rawQuery('''
//       SELECT s.title, count(mainStrategy) from $strategyTable as s,$transactionTable as t
//       where s.title = t.mainStrategy GROUP BY s.title;
// ''');
//     final allPositiveTrByStrat = await db.rawQuery('''
//       SELECT s.title, count(mainStrategy) from $strategyTable as s,$transactionTable as t
//       where (s.title = t.mainStrategy) and (profit>=0) GROUP BY s.title;
// ''');
//     final allStratProfit = await db.rawQuery('''
//       SELECT s.title, sum(profit) from $strategyTable as s,$transactionTable as t
//       where (s.title = t.mainStrategy) GROUP BY s.title;
// ''');
//     final transactionsCount = await db.rawQuery('''
//       SELECT count(*) from $transactionTable;
// ''');
//   }
}
