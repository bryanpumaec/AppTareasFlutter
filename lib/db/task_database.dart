import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskDatabase {
  TaskDatabase._internal();
  static final TaskDatabase instance = TaskDatabase._internal();

  Database? _database;

  Future<Database> get _db async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tareas_uniandes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            dueDate TEXT NOT NULL,
            priority INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<Task> insertTask(Task task) async {
    final db = await _db;
    final id = await db.insert('tasks', task.toMap());
    return task.copyWith(id: id);
  }

  Future<List<Task>> getTasks() async {
    final db = await _db;
    final maps = await db.query('tasks', orderBy: 'id DESC');
    return maps.map(Task.fromMap).toList();
  }
}
