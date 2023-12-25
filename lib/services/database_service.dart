import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';

//Базовый класс взаимодействия с БД
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
    await db.insert(
        strategyTable,
        Strategy(
          title: 'None',
          strategyColor: Colors.lightGreen,
        ).toJson());
    //await createStrategy(Strategy(title: 'none', strategyColor: Colors.amber));
    // log('DB tables created; _createdDB');
    // (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
    //   log(row.values.toString());
    // });
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
