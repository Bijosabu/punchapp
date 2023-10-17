import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../domain/models/userModel.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('User.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableUser (
    ${UserFields.id} $idType,
  ${UserFields.status} $integerType,
  ${UserFields.empCode} $textType,
  ${UserFields.empName} $textType,
  ${UserFields.deptName} $textType,
  ${UserFields.desigName} $textType,
  ${UserFields.empImage} $textType,
  ${UserFields.instName} $textType,
  ${UserFields.instAddress} $textType,
  ${UserFields.instPlace} $textType,
  ${UserFields.northLat} $textType,
  ${UserFields.westLong} $textType,
  ${UserFields.southLat} $textType,
  ${UserFields.eastLong} $textType,
  ${UserFields.empToken} $textType,
  ${UserFields.instId} $integerType,
  ${UserFields.empId} $integerType,
  ${UserFields.userId} $integerType,
  ${UserFields.punchMethod} $textType
    )
    ''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id: id);
  }

  Future<User?> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableUser,
        columns: UserFields.values,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<User>> readAllUserData() async {
    final db = await instance.database;

    final result =
        await db.query(tableUser, orderBy: '${UserFields.empName} ASC');

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
