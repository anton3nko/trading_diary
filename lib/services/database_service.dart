import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:trading_diary/domain/model/strategy.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('trading_diary_db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE strategies (
        _id $idType,
        title $textType,
        color $integerType
      )
    ''');
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

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
