import 'package:plantcare_app/model/user.dart';
import 'package:plantcare_app/provider/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDataAccess {
  String tableName = "users";

  Future<int> insertUser(User user) async {
    Database db = await DatabaseProvider.instance.database;
    Map<String, dynamic> data = user.toMap();

    if (data["id"] == null) {
      data.remove("id");
    }

    return db.insert(tableName, data);
  }

  Future<User?> getUserByUsername(String username) async {
    Database db = await DatabaseProvider.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: "username = ?",
      whereArgs: [username],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return User.fromMap(maps.first);
  }

  Future<User?> loginUser(String username, String password) async {
    Database db = await DatabaseProvider.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return User.fromMap(maps.first);
  }
}
