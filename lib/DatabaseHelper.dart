import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'user_model.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = "users.db";
  static const _dbVersion = 1;
  static const _tableName = "userTable";

  static const columnFirstName = 'firstName';
  static const columnLastName = 'lastName';
  static const columnPin = 'pin';
  static const columnUserType = 'userType';
  static const columnCompletedTrainings = 'completedTrainings';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
      }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $columnFirstName TEXT NOT NULL,
        $columnLastName TEXT NOT NULL,
        $columnPin TEXT NOT NULL,
        $columnUserType INTEGER NOT NULL,
        $columnCompletedTrainings INTEGER NOT NULL
      )
    ''');
  }

  // Insert a user into the database
  Future<void> insertUser(User user) async {
    Database db = await instance.database;
    await db.insert(_tableName, user.toMap());
  }

  // Retrieve all users from the database
  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> userMaps = await db.query(_tableName);
    return List.generate(userMaps.length, (i) {
      return User.fromMap(userMaps[i]);
    });
  }

  Future<void> deleteUser(String firstName, String lastName, String pin) async {
    Database db = await instance.database;
    await db.delete(
      _tableName,
      where: '$columnFirstName = ? AND $columnLastName = ? AND $columnPin = ?',
      whereArgs: [firstName, lastName, pin],
    );
  }
}

