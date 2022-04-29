import 'package:funesia_clone/data/model/local/animal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<dynamic> initDB() async {
    return await openDatabase(
      join(
        await getDatabasesPath(),
        'animal_db',
      ),
    );
  }

  static Future<void> createTable() async {
    await openDatabase(
        join(
          await getDatabasesPath(),
          'animal_db',
        ), onCreate: (db, version) {
      db.execute('CREATE TABLE Animals(id INTEGER PRIMARY KEY, name TEXT)');
    }, version: 1);
  }

  static Future<void> insertDB(Animal animal) async {
    var db = await initDB();
    await db.insert('Animals', animal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Animal>> getAnimals() async {
    final db = await initDB();
    List<Map<String, dynamic>> result = await db.query("Animals");
    print("result $result");
    final out = List.generate(
        result.length,
        (index) =>
            Animal(id: result[index]['id'], name: result[index]['name']));

    return out;
  }
}
