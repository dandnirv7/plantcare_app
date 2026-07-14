import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._init();

  static DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String databasePath = join(directory.path, "plantcare.db");

    return openDatabase(
      databasePath,
      version: 4,
      onCreate: createDatabase,
      onUpgrade: upgradeDatabase,
    );
  }

  Future<void> createDatabase(Database db, int version) async {
    await db.execute("""
CREATE TABLE IF NOT EXISTS my_garden (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  api_id INTEGER,
  name TEXT,
  scientific_name TEXT,
  image_url TEXT,
  local_image_path TEXT,
  local_video_path TEXT,
  watering TEXT,
  sunlight TEXT,
  note TEXT,
  created_at TEXT,
  latitude TEXT,
  longitude TEXT
)
""");

    await createUsersTable(db);
  }

  Future<void> upgradeDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await createUsersTable(db);
    }

    if (oldVersion < 3) {
      await addLocationColumns(db);
    }

    if (oldVersion < 4) {
      await addVideoColumn(db);
    }
  }

  Future<void> createUsersTable(Database db) async {
    await db.execute("""
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE,
  password TEXT,
  created_at TEXT
)
""");
  }

  Future<void> addLocationColumns(Database db) async {
    try {
      await db.execute("ALTER TABLE my_garden ADD COLUMN latitude TEXT");
    } catch (e) {}

    try {
      await db.execute("ALTER TABLE my_garden ADD COLUMN longitude TEXT");
    } catch (e) {}
  }

  Future<void> addVideoColumn(Database db) async {
    try {
      await db.execute("ALTER TABLE my_garden ADD COLUMN local_video_path TEXT");
    } catch (e) {}
  }
}
