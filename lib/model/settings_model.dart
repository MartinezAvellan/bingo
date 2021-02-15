import 'package:sqflite/sqflite.dart';

final String tableSettings = 'settings';
final String columnId = '_id';
final String columnDiretorio = 'diretorio';

class SettingsModel {
  int id;
  String diretorio;

  SettingsModel();

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    var map = <String, dynamic>{
      "title": diretorio,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SettingsModel.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.diretorio = map[columnDiretorio];
  }
}

class SettingsProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''create table $tableSettings ($columnId integer primary key autoincrement, $columnDiretorio text not null) ''');
    });
  }

  Future<SettingsModel> insert(SettingsModel settings) async {
    settings.id = await db.insert(tableSettings, settings.toMap());
    return settings;
  }

  Future<SettingsModel> getTodo(int id) async {
    List<Map> maps = await db.query(tableSettings,
        columns: [columnId, columnDiretorio],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return SettingsModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableSettings, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(SettingsModel settings) async {
    return await db.update(tableSettings, settings.toMap(),
        where: '$columnId = ?', whereArgs: [settings.id]);
  }

  Future close() async => db.close();
}
