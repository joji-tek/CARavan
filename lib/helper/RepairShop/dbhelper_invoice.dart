import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('invoice.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String path) async {
  final dbPath = await getDatabasesPath();
  final dbLocation = join(dbPath, path);
  return await openDatabase(
    dbLocation,
    version: 2, // Update version number to trigger upgrade
    onCreate: _createDB,
    onUpgrade: _onUpgrade,  // Include onUpgrade callback
  );
}


  // Create tables for storing invoice details
  // Create tables for storing booking details
Future<void> _createDB(Database db, int version) async {
  const invoiceTable = '''
    CREATE TABLE bookings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      car_model TEXT,
      license_plate TEXT,
      issue_description TEXT,
      street TEXT,
      barangay TEXT,
      city TEXT,
      province TEXT,
      zip_code TEXT,
      country TEXT,
      landmark TEXT,  -- Add this column if it's missing
      service_provider_name TEXT,  -- Add this column
      service_provider_profile TEXT,  -- Add this column
      is_urgent INTEGER,
      issue_price REAL
    );
  ''';
  await db.execute(invoiceTable);
}

Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    // Add new columns in the case of an upgrade
    await db.execute(''' 
      ALTER TABLE bookings ADD COLUMN service_provider_name TEXT;
    ''');
    await db.execute(''' 
      ALTER TABLE bookings ADD COLUMN service_provider_profile TEXT;
    ''');
  }
}



  // Insert booking details into the database
  Future<void> insertBooking(Map<String, dynamic> booking) async {
    final db = await database;
    await db.insert('bookings', booking, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch booking details from the database
  Future<Map<String, dynamic>?> getBookingDetails(int bookingId) async {
    final db = await database;
    final result = await db.query(
      'bookings',
      where: 'id = ?',
      whereArgs: [bookingId],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // DBHelper class
Future<Map<String, dynamic>?> getLatestTransaction() async {
  final db = await database;
  final result = await db.query(
    'bookings',
    orderBy: 'id DESC', // Order by descending ID to get the latest transaction
    limit: 1, // Only fetch one result
  );
  if (result.isNotEmpty) {
    return result.first; // Return the first result (the latest transaction)
  } else {
    return null; // Return null if no transaction exists
  }
}


}
