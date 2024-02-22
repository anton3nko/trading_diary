import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';

//Базовый класс взаимодействия с БД
//Перенёс CRUD-методы Transactions->transactions_repo.dart
//Strategy->strategies_repo.dart
class DatabaseService {
  DatabaseService._init();

  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static final DatabaseService instance = DatabaseService._init();
  static const integerType = 'INTEGER NOT NULL';
  static const textType = 'TEXT NOT NULL';

  static const _createStrategiesTable = '''
    CREATE TABLE $strategyTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        color INTEGER NOT NULL
      )''';

  static const _createTransactionsTable = '''
    CREATE TABLE $transactionTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TransactionFields.transactionType} TEXT NOT NULL,
        volume REAL NOT NULL,
        currencyPair TEXT NOT NULL,
        openDate TEXT NOT NULL,
        closeDate TEXT,
        mainStrategy TEXT NOT NULL,
        mainStrategyId INTEGER NOT NULL,
        secondaryStrategy TEXT NOT NULL,
        secondaryStrategyId INTEGER NOT NULL,
        timeFrame TEXT NOT NULL,
        profit REAL,
        comment TEXT
    )
''';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('trading_diary_db');
    return _database!;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(_createStrategiesTable);
    await db.execute(_createTransactionsTable);
    await db.insert(
        strategyTable,
        Strategy(
          title: 'None',
          strategyColor: Colors.lightGreen,
        ).toJson());
  }
}
