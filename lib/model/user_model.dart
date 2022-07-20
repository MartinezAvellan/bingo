import 'package:sqflite/sqflite.dart';

final String tableUser = 'user';
final String columnId = '_id';
final String columnUserName = 'usaer_name';
final String columnPassword = 'password';

class UserModel {
  int id;
  String userName;
  String password;

  UserModel();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "title": userName,
      "content": password,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.userName = map[columnUserName];
    this.password = map[columnPassword];
  }
}

class UserProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''create table $tableUser ($columnId integer primary key autoincrement, $columnUserName text not null, $columnPassword text not null) ''');
    });
  }

  Future<UserModel> insert(UserModel user) async {
    user.id = await db.insert(tableUser, user.toMap());
    return user;
  }

  Future<UserModel> getTodo(int id) async {
    List<Map> maps = await db.query(tableUser,
        columns: [columnId, columnUserName, columnPassword],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(UserModel user) async {
    return await db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async => db.close();
}
