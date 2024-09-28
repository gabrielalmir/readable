import 'package:path/path.dart';
import 'package:readable/models/book.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'books.db');

    return await openDatabase(
      databasePath,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id TEXT PRIMARY KEY,
        title TEXT,
        authors TEXT,
        thumbnail TEXT,
        description TEXT,
        maturityRating TEXT,
        rating INTEGER,
        isFavorite INTEGER DEFAULT 0,
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE books ADD COLUMN rating INTEGER DEFAULT 0');
    }
    if (oldVersion < 3) {
      await db
          .execute('ALTER TABLE books ADD COLUMN isFavorite INTEGER DEFAULT 0');
    }
  }

  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert('books', book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteBook(String id) async {
    final db = await database;
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final result = await db.query('books');
    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<void> updateBook(Book book) async {
    final db = await database;
    await db
        .update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
  }
}
