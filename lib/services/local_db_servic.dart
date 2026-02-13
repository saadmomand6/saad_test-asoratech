import 'package:path/path.dart';
import 'package:saad_test/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id TEXT PRIMARY KEY,
            title TEXT,
            category TEXT,
            priority INTEGER,
            createdAt INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertTasks(List<TaskModel> tasks) async {
    final db = await database;

    await db.delete('tasks');

    for (var task in tasks) {
      await db.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final maps = await db.query('tasks');

    return maps.map((e) => TaskModel.fromMap(e)).toList();
  }
}
