import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDatabase();
    return _database!;
  }

  // Method to open the database
  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app.db');

    return await openDatabase(
      path,
      version: 2, // Increase version to 2 for the schema change
      onCreate: (db, version) async {
        // Create users table (version 1)
        await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL,
          user_type INTEGER NOT NULL CHECK(user_type IN (1, 2)), -- 1: Car Buy/Sell/Rent, 2: Car Repair Shop
          additional_info TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Create a new users table with the `name` column instead of `username`
          await db.execute('''
          CREATE TABLE users_new (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            user_type INTEGER NOT NULL CHECK(user_type IN (1, 2)),
            additional_info TEXT
          )
        ''');

          // Copy the data from the old table to the new one
          await db.execute('''
          INSERT INTO users_new (id, name, email, password, user_type, additional_info)
          SELECT id, username, email, password, user_type, additional_info
          FROM users
        ''');

          // Drop the old table
          await db.execute('DROP TABLE users');

          // Rename the new table to the original name
          await db.execute('ALTER TABLE users_new RENAME TO users');
        }
      },
    );
  }

  // Register a new user
  Future<int> registerUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      return await db.insert('users', user);
    } catch (e) {
      // print('Error registering user: $e');
      return -1; // Return -1 to indicate failure
    }
  }

  // Login a user
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final db = await database;
      final result = await db.query(
        'users',
        where: 'email= ? AND password = ?',
        whereArgs: [email, password],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      // print('Error logging in user: $e');
      return null;
    }
  }

  // Create a session
  Future<int> createSession(int userId, String token) async {
    try {
      final db = await database;
      final session = {
        'user_id': userId,
        'token': token,
        'created_at': DateTime.now().toIso8601String(),
      };
      return await db.insert('sessions', session);
    } catch (e) {
      // print('Error creating session: $e');
      return -1; // Return -1 to indicate failure
    }
  }

  // Validate a session token
  Future<Map<String, dynamic>?> validateSession(String token) async {
    try {
      final db = await database;
      final result = await db.query(
        'sessions',
        where: 'token = ?',
        whereArgs: [token],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      // print('Error validating session: $e');
      return null;
    }
  }

  // Logout a user by deleting their session
  Future<int> logoutUser(String token) async {
    try {
      final db = await database;
      return await db.delete(
        'sessions',
        where: 'token = ?',
        whereArgs: [token],
      );
    } catch (e) {
      // print('Error logging out user: $e');
      return -1; // Return -1 to indicate failure
    }
  }

  // Fetch all users (for admin or debugging purposes)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await database;
      return await db.query('users');
    } catch (e) {
      // print('Error fetching all users: $e');
      return [];
    }
  }

  // Fetch all sessions (for admin or debugging purposes)
  Future<List<Map<String, dynamic>>> getAllSessions() async {
    try {
      final db = await database;
      return await db.query('sessions');
    } catch (e) {
      // print('Error fetching all sessions: $e');
      return [];
    }
  }
}
