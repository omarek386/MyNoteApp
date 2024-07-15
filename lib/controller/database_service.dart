import 'dart:async';
import 'dart:io';

import 'package:asfasfasf/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MySqlDatabaseService {
  // MySqlDatabaseService._privateController();
  // static final instance = MySqlDatabaseService._privateController();
  static const _dbName = "notes.db";
  static const _dbVersion = 5;
  static const _tableName = "notes";

  Database? _db;

  get database async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDatabase();
      return _db;
    }
  }

//* init Database
  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER  PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        timeEdited TEXT NOT NULL,
        timeCreated TEXT NOT NULL,
        contentWordCount INTEGER NOT NULL,
        contentCharCount INTEGER NOT NULL
      )
      ''');
  }

//* Add  Notes
  Future<int> addNote(Note note) async {
    Database db = await database;
    return await db.insert(_tableName, note.toMap());
  }

//* Delete  Note
  Future<int> deleteNote(Note note) async {
    Database db = await database;
    return await db.delete(_tableName, where: "id = ?", whereArgs: [note.id]);
  }

//* Delete All Notes
  Future<int> deleteAllNotes() async {
    Database db = await database;
    return await db.delete(_tableName);
  }

//* Update Notes
  Future<int> updateNote(Note note) async {
    Database db = await database;
    return await db.update(_tableName, note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }

//* get Notes List
  Future<List<Note>> getNotesList() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(
      maps.length,
      (index) {
        return Note(
          id: maps[index]['id'],
          content: maps[index]['content'],
          timeCreated: maps[index]['timeCreated'],
          timeEdited: maps[index]['timeEdited'],
          title: maps[index]['title'],
          contentCharCount: maps[index]['contentCharCount'],
          contentWordCount: maps[index]['contentWordCount'],
        );
      },
    );
  }
}
