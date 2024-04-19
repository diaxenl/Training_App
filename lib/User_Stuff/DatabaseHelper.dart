import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './user_model.dart';

/// A singleton class for managing database operations for users.
class DatabaseHelper {
  // Database configuration constants
  static const _dbName = 'users.db';
  static const _dbVersion = 2;
  static const _tableName = 'userTable';

  // Column names for the user table
  static const columnFirstName = 'firstName';
  static const columnLastName = 'lastName';
  static const columnPin = 'pin';
  static const columnUserType = 'userType';
  static const columnCompletedTrainings = 'completedTrainings';
  static const columnQuiz1Completed = 'quiz1Completed';  // Column for quiz 1 completion status
  static const columnQuiz2Completed = 'quiz2Completed';  // Column for quiz 2 completion status

  // Creating a private constructor for this singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  /// Lazily initializes the database the first time it is accessed.
  Future<Database> get database async => _database ??= await _initiateDatabase();

  /// Initializes the database by setting the path and opening the database.
  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  /// Creates the table during the first installation of the database.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        pin TEXT NOT NULL,
        userType INTEGER NOT NULL,
        completedTrainings INTEGER NOT NULL,
        quiz1Completed INTEGER NOT NULL DEFAULT 0,
        quiz2Completed INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  /// Handles upgrading the database to a new version.
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE $_tableName ADD COLUMN $columnQuiz1Completed INTEGER NOT NULL DEFAULT 0');
      await db.execute('ALTER TABLE $_tableName ADD COLUMN $columnQuiz2Completed INTEGER NOT NULL DEFAULT 0');
    }
  }

  /// Updates the quiz 1 completion status for a user.
  Future<void> updateUserQuiz1Completion(int userId, bool quiz1Completed) async {
    Database db = await database;
    await db.update(
        _tableName,
        {'quiz1Completed': quiz1Completed ? 1 : 0},
        where: 'id = ?',
        whereArgs: [userId]
    );
  }

  /// Updates the quiz 2 completion status for a user.
  Future<void> updateUserQuiz2Completion(int userId, bool quiz2Completed) async {
    Database db = await database;
    await db.update(
        _tableName,
        {'quiz2Completed': quiz2Completed ? 1 : 0},
        where: 'id = ?',
        whereArgs: [userId]
    );
  }

  /// Inserts a new user into the database.
  Future<void> insertUser(User user) async {
    Database db = await instance.database;
    await db.insert(_tableName, user.toMap());
  }

  /// Retrieves all users from the database.
  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> userMaps = await db.query(_tableName);
    return List.generate(userMaps.length, (i) => User.fromMap(userMaps[i]));
  }

  /// Updates the quiz score for a user in the database.
  Future<void> updateQuizScore(int userID, int quiz1Completed) async {
    Database db = await database;
    await db.rawUpdate(
        'UPDATE $_tableName SET $columnQuiz1Completed = ? WHERE id = ?',
        [quiz1Completed, userID]
    );
  }

  /// Deletes a user from the database.
  Future<void> deleteUser(String firstName, String lastName, String pin) async {
    Database db = await instance.database;
    await db.delete(
        _tableName,
        where: '$columnFirstName = ? AND $columnLastName = ? AND $columnPin = ?',
        whereArgs: [firstName, lastName, pin]
    );
  }
}
