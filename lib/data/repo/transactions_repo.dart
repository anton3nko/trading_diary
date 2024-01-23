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

  Future<List<Map<String, dynamic>>> calculateTopStrategies(
      DateTime startDate, DateTime endDate) async {
    final db = await dbContext.database;
    final totalStrategies = await db.rawQuery('''
      SELECT ${StrategyFields.id},${StrategyFields.title} from $strategyTable;
''');
    log(totalStrategies.toString(), name: 'totalStrategies');
    //Общее количество сделок по каждой из стратегий
    final totalTransactions = await db.rawQuery('''
      SELECT s.title, sum(CASE WHEN s.${StrategyFields.id} = t.${TransactionFields.mainStrategyId} 
      AND (t.${TransactionFields.openDate} BETWEEN '$startDate' AND '$endDate') THEN 1 ELSE 0 END) as count, s.color from $strategyTable as s LEFT OUTER JOIN
      $transactionTable as t ON s._id = t.${TransactionFields.mainStrategyId}
      GROUP BY s._id;
''');
    log(totalTransactions.toString(), name: 'totalTransactions');
    //Общее количество прибыльных сделок по каждой из стратегий
    final totalProfitTrans = await db.rawQuery('''
       SELECT s.title, sum(CASE WHEN profit>0 AND (t.${TransactionFields.openDate}
      BETWEEN '$startDate' AND '$endDate') THEN 1 ELSE 0 END) as count from 
       $strategyTable as s LEFT OUTER JOIN
       $transactionTable as t ON s._id = t.${TransactionFields.mainStrategyId} 
       GROUP BY s._id;
 ''');
    log(totalProfitTrans.toString(), name: 'totalProfitTrans');
    //Прибыль по каждой их стратегий
    final totalProfit = await db.rawQuery('''
      SELECT s.title, sum(CASE WHEN s.${StrategyFields.id} = t.${TransactionFields.mainStrategyId} 
      AND (t.${TransactionFields.openDate}
      BETWEEN '$startDate' AND '$endDate')
      THEN t.${TransactionFields.profit} ELSE 0.0 END) as profit, s.color from $strategyTable as s LEFT OUTER JOIN
      $transactionTable as t ON s._id = t.${TransactionFields.mainStrategyId}
      GROUP BY s._id;
''');
    log(totalProfit.toString(), name: 'totalProfit');
    //Формирую List<Map<String, dynamic>>, где элемент списка - каждая из стратегий
    // [{'title':'Стратегия 1', 'total_count':'3',
    // 'profitable':'2','profit':'57.43', 'color':'4287349578'}]
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

  //TODO Расчет текущей прибыли
  Future<double> calculateProfit() async {
    final db = await dbContext.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT sum(profit)as total_profit from $transactionTable;
''');
    log(result.toString(), name: 'balance');
    log(result[0]['total_profit'].toString(), name: 'balance');
    if (result[0]['total_profit'].runtimeType != Null) {
      return result[0]['total_profit'];
    } else {
      return 0;
    }
  }
}