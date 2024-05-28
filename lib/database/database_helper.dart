import 'package:learning/student_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DataBaseHelper {
  static  Database? _db;

  //check if database is already there if not create
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    var pathProvider = await getApplicationDocumentsDirectory();
    String path = join(pathProvider.path, "student.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE student(id INTERGER PRIMARY KEY,name TEXT)');
  }

  //
  Future<Student> addStudent(Student student) async {
    var dbClient = await db;
    dbClient.insert('student', student.toMap());
    return student;
  }

  Future<List<Student>> getAllStudent() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.query('student', columns: ['id', 'name']);
    List<Student> student = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        student.add(Student.fromMap(maps[i]));
      }
    }
    return student;
  }

  Future<bool> updateData(Student student) async {
    try {
      var dbClient = await db;
      dbClient.update('student', student.toMap(),
          where: 'id = ?', whereArgs: [student.id]);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> deleteStudent(int id)async{
    var dbClient = await db;
    return dbClient.delete('student',where: 'id == ?',whereArgs: [id]);
     
  }

  //    initDatabase() async {
  //   io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentDirectory.path, 'student.db');
  //   var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  //   return db;
  // }

  // _onCreate(Database db, int version) async {
  //   await db
  //       .execute('CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT)');
  // }
}
