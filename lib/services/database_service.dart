import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';

//Класс для взаимодействия с БД
//TODO Найти более лаконичное решение(не все методы взаимодействия с БД в этом классе)
class DatabaseService {
  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const textType = 'TEXT NOT NULL';
  static const integerType = 'INTEGER NOT NULL';

  static const _createStrategiesTable = '''
    CREATE TABLE $strategyTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        color INTEGER NOT NULL
      )''';
//TODO подумать не сохранять ли mainStrategy и secondaryStrategy в виде id из таблицы Strategies?
  static const _createTransactionsTable = '''
    CREATE TABLE $transactionTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TransactionFields.transactionType} TEXT NOT NULL,
        volume REAL NOT NULL,
        currencyPair TEXT NOT NULL,
        openDate TEXT NOT NULL,
        closeDate TEXT,
        mainStrategy TEXT NOT NULL,
        secondaryStrategy TEXT NOT NULL,
        timeFrame TEXT NOT NULL,
        profit REAL,
        comment TEXT
    )
''';

  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('trading_diary_db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    log('_initDB');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(_createStrategiesTable);
    await db.execute(_createTransactionsTable);
    // log('DB tables created; _createdDB');
    // (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
    //   log(row.values.toString());
    // });
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

//Strategy CRUD - методы (create, read, update, delete)
  Future<Strategy> createStrategy(Strategy strategy) async {
    final db = await instance.database;
    final id = await db.insert(strategyTable, strategy.toJson());
    return strategy.copy(id: id);
  }

  Future<Strategy> readStrategy({required int id}) async {
    final db = await instance.database;

    final maps = await db.query(
      strategyTable,
      columns: StrategyFields.values,
      where: '${StrategyFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Strategy.fromJson(maps.first);
    } else {
      throw Exception('ID $id was not found');
    }
  }

  Future<List<Strategy>> readAllStrategies() async {
    final db = await instance.database;
    const orderBy = '${StrategyFields.id} ASC';
    final result = await db.query(strategyTable, orderBy: orderBy);

    return result.map((json) => Strategy.fromJson(json)).toList();
  }

  Future<int> updateStrategy({required Strategy strategy}) async {
    final db = await instance.database;

    return db.update(
      strategyTable,
      strategy.toJson(),
      where: '${StrategyFields.id} = ?',
      whereArgs: [strategy.id],
    );
  }

  Future<int> deleteStrategy({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      strategyTable,
      where: '${StrategyFields.id} = ?',
      whereArgs: [id],
    );
  }

  //Transaction CRUD - методы (create, read, update, delete)
  Future<TradingTransaction> createTransaction(
      TradingTransaction transaction) async {
    final db = await instance.database;
    final id = await db.insert(transactionTable, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<TradingTransaction> readTransaction({required int id}) async {
    final db = await instance.database;

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
    log('readAllTransactions() call');
    final db = await instance.database;
    const orderBy = '${TransactionFields.id} ASC';
    final result = await db.query(transactionTable, orderBy: orderBy);

    return result.map((json) => TradingTransaction.fromJson(json)).toList();
  }

  Future<int> updateTransaction(
      {required TradingTransaction transaction}) async {
    final db = await instance.database;

    return db.update(
      transactionTable,
      transaction.toJson(),
      where: '${TransactionFields.id} = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      transactionTable,
      where: '${TransactionFields.id} = ?',
      whereArgs: [id],
    );
  }
}
