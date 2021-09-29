import 'dart:io';
import 'package:notes/models/notes_models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  NotesDatabase._privateConstructor();
  static final instance = NotesDatabase._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory notesDirectory = await getApplicationDocumentsDirectory();
    String path = join(notesDirectory.path, 'notes.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''Create Table notes(
     id INTEGER PRIMARY KEY,
     title TEXT,
     description TEXT
   )''');
  }

  Future<List<NotesModels>> getNotes() async {
    Database db = await instance.database;
    var notes = await db.query('notes', orderBy: 'title');
    List<NotesModels> notesList = notes.isNotEmpty
        ? notes.map((e) => NotesModels.fromMap(e)).toList()
        : [];
    return notesList;
  }

  Future<int> add(NotesModels notess) async {
    Database db = await instance.database;
    return db.insert('notes', notess.toMap());
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return db.delete('notes', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(NotesModels notess) async {
    Database db = await instance.database;
    return await db
        .update('notes', notess.toMap(), where: 'id=?', whereArgs: [notess.id]);
  }
}
