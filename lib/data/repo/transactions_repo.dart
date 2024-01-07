import 'dart:developer';

import 'package:trading_diary/domain/model/strategy.dart';
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

  Future<List<Map<String, dynamic>>> calculateTopStrategies() async {
    final db = await dbContext.database;
    //Собираю количество сделок по каждой из стратегий
    final totalTransactions = await db.rawQuery('''
      SELECT s.title, count(mainStrategy) as count, s.color from $strategyTable as s,$transactionTable as t
      where s._id = t.${TransactionFields.mainStrategyId} GROUP BY s._id;
''');
    log(totalTransactions.toString(), name: 'totalTransactions');
    final totalProfitTrans = await db.rawQuery('''
       SELECT s.title, sum(CASE WHEN profit>0 THEN 1 ELSE 0 END) as count from $strategyTable as s LEFT OUTER JOIN
       $transactionTable as t ON s._id = t.${TransactionFields.mainStrategyId} 
       GROUP BY s._id;
 ''');
    log(totalProfitTrans.toString(), name: 'totalProfitTrans');
    final totalProfit = await db.rawQuery('''
      SELECT s.title, sum(profit) as profit from $strategyTable as s,$transactionTable as t
      where (s._id = t.${TransactionFields.mainStrategyId}) GROUP BY s._id;
''');
    log(totalProfit.toString(), name: 'totalProfit');
    List<Map<String, dynamic>> result = [];
    if (totalProfit.isNotEmpty) {
      for (var i = 0; i < totalTransactions.length; i++) {
        log('${i.toString()},${totalProfitTrans.isNotEmpty},${totalTransactions.length}',
            name: 'i ravno');
        Map<String, dynamic> strat = {};
        strat['title'] = totalTransactions[i]['title'];
        strat['total_count'] = totalTransactions[i]['count'];
        strat['profitable'] = totalProfitTrans[i]['count'];
        strat['profit'] =
            (totalProfit[i]['profit'] as double).toStringAsFixed(2);
        strat['color'] = totalTransactions[i]['color'];
        result.add(strat);
      }
      log(result.toString(), name: 'result');
      result.sort(
        (a, b) =>
            (double.parse(a['profit'])).compareTo(double.parse(b['profit'])),
      );
      log(result.reversed.toList().toString(), name: 'result');
      return result.reversed.toList();
    } else {
      return [];
    }
  }
}
