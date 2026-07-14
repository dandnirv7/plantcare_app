import 'package:plantcare_app/model/my_plant.dart';
import 'package:plantcare_app/provider/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyPlantDataAccess {
  String tableName = "my_garden";

  Future<int> insertPlant(MyPlant plant) async {
    Database db = await DatabaseProvider.instance.database;
    Map<String, dynamic> data = plant.toMap();
    data.remove("id");

    return db.insert(tableName, data);
  }

  Future<List<MyPlant>> getAllPlants() async {
    Database db = await DatabaseProvider.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: "id DESC",
    );

    return maps.map((map) => MyPlant.fromMap(map)).toList();
  }

  Future<MyPlant?> getPlantById(int id) async {
    Database db = await DatabaseProvider.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return MyPlant.fromMap(maps.first);
  }

  Future<int> updatePlant(MyPlant plant) async {
    Database db = await DatabaseProvider.instance.database;
    Map<String, dynamic> data = plant.toMap();

    return db.update(
      tableName,
      data,
      where: "id = ?",
      whereArgs: [plant.id],
    );
  }

  Future<int> deletePlant(int id) async {
    Database db = await DatabaseProvider.instance.database;
    return db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
