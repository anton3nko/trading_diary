import 'package:trading_diary/services/database_service.dart';
import 'package:trading_diary/domain/model/strategy.dart';

class StrategiesRepo {
  static final StrategiesRepo instance = StrategiesRepo._();
  final dbContext = DatabaseService.instance;
  StrategiesRepo._();

  //Strategy CRUD - методы (create, read, update, delete)
  Future<Strategy> createStrategy(Strategy strategy) async {
    final db = await dbContext.database;
    final id = await db.insert(strategyTable, strategy.toJson());
    return strategy.copy(id: id);
  }

  Future<Strategy> readStrategy({required int id}) async {
    final db = await dbContext.database;

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
    final db = await dbContext.database;
    const orderBy = '${StrategyFields.id} ASC';
    final result = await db.query(strategyTable, orderBy: orderBy);

    return result.map((json) => Strategy.fromJson(json)).toList();
  }

  Future<int> updateStrategy({required Strategy strategy}) async {
    final db = await dbContext.database;

    return db.update(
      strategyTable,
      strategy.toJson(),
      where: '${StrategyFields.id} = ?',
      whereArgs: [strategy.id],
    );
  }

  Future<int> deleteStrategy({required int id}) async {
    final db = await dbContext.database;

    return await db.delete(
      strategyTable,
      where: '${StrategyFields.id} = ?',
      whereArgs: [id],
    );
  }
}
