import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_postit/models/notes_model.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  // criando o getter da database
  Future<Database> get database async {
    // primeiro vamos checar se temos um db
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

    initDB() async {
      return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
          onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT, 
          body TEXT 
        )
        ''');
      }, version: 1);
    }

    addNewNote(NoteModel note) async {
      final db = await database;
      db.insert("notes", note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // get notes table
    Future<dynamic> getNotes() async {
      final db = await database;
      var res = await db.query("notes");

      if(res.length == 0){
        return Null;
      } else {
        var resultMap = res.toList();
        return resultMap.isNotEmpty ? resultMap : Null;
      }
    }

    Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id = ?", [id]);
    return count;
  }
}
