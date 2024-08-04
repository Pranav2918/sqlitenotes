import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqlitedemo/data/model/note_model.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path, "notes.db");
    var db = await openDatabase(path,
        version: 1, onCreate: (db, version) => _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL)");
  }

  Future<NoteModel> insertNote(NoteModel noteModel) async {
    var dbClient = await db;
    dbClient!.insert("notes", noteModel.toMap());
    return noteModel;
  }

  Future<List<NoteModel>> getNotesList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query("notes");
    return queryResult
        .map(
          (e) => NoteModel.fromMap(e),
        )
        .toList();
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient!.delete("notes", where: "id = ?", whereArgs: [id]);
  }

  Future<int> editNote(NoteModel noteModel) async {
    var dbClient = await db;
    return await dbClient!.update("notes", noteModel.toMap(),
        where: "id = ?", whereArgs: [noteModel.id]);
  }
}
