import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppointmentsDBHelper {
  static const _databaseName = 'appointments.db';
  static const _databaseVersion = 1;

  static const table = 'appointments';
  static const columnId = 'id';
  static const columnCarModel = 'car_model';
  static const columnLicensePlate = 'license_plate';
  static const columnIssueDescription = 'issue_description';
  static const columnServiceType = 'service_type';
  static const columnDriversLicense = 'drivers_license';
  static const columnStreet = 'street';
  static const columnCity = 'city';
  static const columnState = 'state';
  static const columnZipCode = 'zip_code';
  static const columnCountry = 'country';
  static const columnLandmark = 'landmark';
  static const columnAppointmentDate = 'appointment_date';
  static const columnAppointmentTime = 'appointment_time';
  static const columnAdditionalNotes = 'additional_notes';
  static const columnPrice = 'price';

  AppointmentsDBHelper._privateConstructor();
  static final AppointmentsDBHelper instance = AppointmentsDBHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the table when the database is first created
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCarModel TEXT,
        $columnLicensePlate TEXT,
        $columnIssueDescription TEXT,
        $columnServiceType TEXT,
        $columnDriversLicense TEXT,
        $columnStreet TEXT,
        $columnCity TEXT,
        $columnState TEXT,
        $columnZipCode TEXT,
        $columnCountry TEXT,
        $columnLandmark TEXT,
        $columnAppointmentDate TEXT,
        $columnAppointmentTime TEXT,
        $columnAdditionalNotes TEXT,
        $columnPrice REAL
      )
    ''');
  }

  // Insert a new appointment
  Future<int> insertAppointment(Map<String, dynamic> appointment) async {
    Database db = await instance.database;
    return await db.insert(table, appointment);
  }

  // Get all appointments
  Future<List<Map<String, dynamic>>> getAppointments() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Get an appointment by id
  Future<Map<String, dynamic>?> getAppointment(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update an appointment
  Future<int> updateAppointment(Map<String, dynamic> appointment) async {
    Database db = await instance.database;
    int id = appointment[columnId];
    return await db.update(
      table,
      appointment,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete an appointment
  Future<int> deleteAppointment(int id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
