import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'booking_repair.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }
 
  


  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE Cars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        model TEXT NOT NULL,
        license_plate TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES Users(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE Bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_model TEXT NOT NULL,
        license_plate TEXT NOT NULL,
        issue_description TEXT NOT NULL,
        price INTEGER NOT NULL,
        street TEXT,
        barangay TEXT,
        city TEXT,
        province TEXT,
        zip_code TEXT,
        country TEXT,
        landmark TEXT,
        additional_notes TEXT,
        paid TEXT NOT NULL
      );
    ''');

    
  }


  Future<int?> insertBooking(Map<String, dynamic> booking) async {
    final db = await database;
    return await db.insert('Bookings', booking);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database schema upgrades if needed
  }

  Future<Map<String, dynamic>?> getBookingDetails(int bookingId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'Bookings',
      where: 'id = ?',
      whereArgs: [bookingId],
    );
    if (result.isNotEmpty) {
      return result.first; // Return the first (and only) matching booking
    }
    return null; // Return null if no matching booking is found
  }

  Future<List<Map<String, dynamic>>> getAllBookings() async {
  final db = await database;
  return await db.query('Bookings'); // Retrieve all records from the 'Bookings' table
}
Future<int> deleteBooking(int id) async {
  final db = await database;
  return await db.delete('Bookings', where: 'id = ?', whereArgs: [id]);
}




}
