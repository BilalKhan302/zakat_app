// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' ;
//
// const _tableName = 'vehicles';
//  const columnId = 'id';
//  const columnName = 'name';
//  const columnRegistrationNumber = 'registrationNumber';
//  const columnPurchaseYear = 'purchaseYear';
//  const columnSellingYear = 'sellingYear';
//  const columnTotalVehicle = 'totalVehicle';
//  const columnTotalAmount = 'totalAmount';
//
//  class DatabaseHelper {
//   static Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//
//     _database = await initializeDatabase();
//     return _database;
//   }
//
//   Future<Database> initializeDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'vehicle_database.db');
//
//     return await openDatabase(
//       path,
//       version: 3,
//       onCreate: (Database db, int version) async {
//         await db.execute('''
//         CREATE TABLE $_tableName (
//           $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//           $columnName TEXT,
//           $columnRegistrationNumber TEXT,
//           $columnPurchaseYear INTEGER,
//           $columnSellingYear INTEGER,
//           $columnTotalVehicle TEXT,
//           $columnTotalAmount TEXT
//         )
//       ''');
//       },
//       onUpgrade: (Database db, int oldVersion, int newVersion) async {
//         if (oldVersion < 3) {
//           final columns = await db.rawQuery('PRAGMA table_info($_tableName)');
//           final columnNames = columns.map((column) => column['name'] as String).toList();
//
//           if (!columnNames.contains(columnTotalVehicle)) {
//             await db.execute('ALTER TABLE $_tableName ADD COLUMN $columnTotalVehicle TEXT');
//           }
//
//           if (!columnNames.contains(columnTotalAmount)) {
//             await db.execute('ALTER TABLE $_tableName ADD COLUMN $columnTotalAmount TEXT');
//           }
//         }
//       },
//     );
//   }
//
//
//
//   Future<int> insertVehicle(Vehicle vehicle) async {
//     final db = await database;
//     return await db!.insert(_tableName, vehicle.toMap());
//   }
//
//   Future<List<Vehicle>> getAllVehicles() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db!.query(_tableName);
//
//     return List.generate(maps.length, (index) {
//       return Vehicle(
//         id: maps[index][columnId],
//         ownerName: maps[index][columnName],
//         registrationNumber: maps[index][columnRegistrationNumber],
//         purchaseYear: maps[index][columnPurchaseYear],
//         sellingYear: maps[index][columnSellingYear],
//         totalVehicle: maps[index][columnTotalVehicle],
//         totalAmount: maps[index][columnTotalAmount],
//       );
//
//     });
//   }
// }
// // vehicle model
// class Vehicle {
//   final int id;
//   final String ownerName;
//   final String registrationNumber;
//   final int purchaseYear;
//   final int sellingYear;
//   final String totalVehicle;
//   final String totalAmount;
//
//   Vehicle( {
//     required this.id,
//     required this.ownerName,
//     required this.registrationNumber,
//     required this.purchaseYear,
//     required this.sellingYear,
//     required  this.totalVehicle,
//     required this.totalAmount,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       columnId:id,
//       columnName: ownerName,
//       columnRegistrationNumber: registrationNumber,
//       columnPurchaseYear: purchaseYear,
//       columnSellingYear: sellingYear,
//       columnTotalVehicle:totalVehicle,
//       columnTotalAmount:totalAmount
//     };
//   }
// }
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();

  // Define table and column names
  static const String tableName = 'vehicle_table';
  static const String columnId = 'columnId';
  static const String ownerName = 'ownerName';
  static const String registrationNumber = 'registrationNumber';
  static const String vehicleId = 'vehicleId';
  static const String totalVehicle = 'totalVehicle';
  static const String totalAmount = 'totalAmount';
  static const String sellingYear = 'sellingYear'; // New column
  static const String purchaseYear = 'purchaseYear';// New column

  //2nd table
  static const String table2 = 'vehicle_installments';
  static const String id = 'id';
  static const String vehicleIdRef   = 'vehicleIdRef';
  static const String month    = 'month';
  static const String installmentAmount     = 'installmentAmount';
  static const String janInstallment     = 'janInstallment';
  static const String febInstallment     = 'febInstallment';
  static const String marInstallment     = 'marInstallment';
  static const String aprInstallment     = 'aprInstallment';
  static const String mayInstallment     = 'mayInstallment';
  static const String junInstallment     = 'junInstallment';
  static const String julInstallment     = 'julInstallment';
  static const String augInstallment     = 'augInstallment';
  static const String sepInstallment     = 'sepInstallment';
  static const String octInstallment     = 'octInstallment';
  static const String novInstallment     = 'novInstallment';
  static const String decInstallment     = 'decInstallment';
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'vehicle_database.db');
    final database = await openDatabase(
      path,
      version: 2,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );

    await _createDatabaseTables(database);

    return database;
  }

  Future<void> _createDatabaseTables(Database db) async {
    if (!await _tableExists(db, tableName)) {
      await _createVehicleTable(db);
    }
    if (!await _tableExists(db, table2)) {
      await _createVehicleInstallmentsTable(db);
    }
  }

  Future<void> _createVehicleTable(Database db) async {
    await db.execute('''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $ownerName TEXT NOT NULL,
      $registrationNumber TEXT NOT NULL,
      $vehicleId INTEGER NOT NULL,
      $totalVehicle INTEGER NOT NULL,
      $totalAmount REAL NOT NULL,
      $sellingYear INTEGER, 
      $purchaseYear INTEGER
    )
  ''');
  }

  Future<void> _createVehicleInstallmentsTable(Database db) async {
    await db.execute('''
    CREATE TABLE $table2 (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $vehicleIdRef INTEGER,
      $janInstallment REAL,
      $febInstallment REAL,
      $marInstallment REAL,
      $aprInstallment REAL,
      $mayInstallment REAL,
      $junInstallment REAL,
      $julInstallment REAL,
      $augInstallment REAL,
      $sepInstallment REAL,
      $octInstallment REAL,
      $novInstallment REAL,
      $decInstallment REAL,
      FOREIGN KEY ($vehicleIdRef) REFERENCES $tableName ($columnId)
    )
  ''');
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      if (!await _tableExists(db, table2)) {
        await _createVehicleInstallmentsTable(db);
      }
    }
  }

  Future<bool> _tableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'"
    );
    return result.isNotEmpty;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $ownerName TEXT NOT NULL,
      $registrationNumber TEXT NOT NULL,
      $vehicleId INTEGER NOT NULL,
      $totalVehicle INTEGER NOT NULL,
      $totalAmount REAL NOT NULL,
      $sellingYear INTEGER, 
      $purchaseYear INTEGER
    )
  ''');
  }

  Future<int> insertVehicle(Map<String, dynamic> vehicleData) async {
    final db = await instance.database;
    return db.insert(tableName, vehicleData);
  }
  //installments
  Future<int> insertVehicleInstallmentsDetails(Map<String, dynamic> vehicleData) async {
    final db = await instance.database;
    return db.insert(table2, vehicleData);
  }

  Stream<List<Map<String, Object?>>> getAllVehicles() async* {
    final db = await instance.database;
    yield* db.query(tableName).asStream();
  }
  //installments
  Stream<List<Map<String, Object?>>> vehicleInstallmentsDetailsList() async* {
    final db = await instance.database;
    yield* db.query(table2).asStream();
  }

  Future<Map<String, dynamic>> getVehicleById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? maps.first : {};
  }

  Future<int> updateVehicle(Map<String, dynamic> vehicleData) async {
    final db = await instance.database;
    final int id = vehicleData[columnId];
    return db.update(
      tableName,
      vehicleData,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteVehicle(int id) async {
    final db = await instance.database;
    return db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }
}
class Vehicle {
  int? columnId;
  String ownerName;
  String registrationNumber;
  int vehicleId;
  int totalVehicle;
  double totalAmount;
  int? sellingYear; // New property
  int? purchaseYear; // New property
  // List<double> monthlyInstallments;


  Vehicle({
    this.columnId,
    required this.ownerName,
    required this.registrationNumber,
    required this.vehicleId,
    required this.totalVehicle,
    required this.totalAmount,
    this.sellingYear,
    this.purchaseYear,
    // required this.monthlyInstallments, // New property
  });

  Map<String, dynamic> toMap() {
    return {
      'columnId': columnId,
      'ownerName': ownerName,
      'registrationNumber': registrationNumber,
      'vehicleId': vehicleId,
      'totalVehicle': totalVehicle,
      'totalAmount': totalAmount,
      'sellingYear': sellingYear, // New field
      'purchaseYear': purchaseYear, // New field

    };
  }

  static Vehicle fromMap(Map<String, dynamic> map) {
    return Vehicle(
      columnId: map['columnId'],
      ownerName: map['ownerName'],
      registrationNumber: map['registrationNumber'],
      vehicleId: map['vehicleId'],
      totalVehicle: map['totalVehicle'],
      totalAmount: map['totalAmount'],
      sellingYear: map['sellingYear'], // New field
      purchaseYear: map['purchaseYear'],


    );
  }
}

class VehicleInstallments {
  int id;
  int vehicleIdRef;
  double janInstallment;
  double febInstallment;
  double marInstallment;
  double aprInstallment;
  double mayInstallment;
  double junInstallment;
  double julInstallment;
  double augInstallment;
  double sepInstallment;
  double octInstallment;
  double novInstallment;
  double decInstallment;

  VehicleInstallments({
    required this.id,
    required this.vehicleIdRef,
    required this.janInstallment,
    required this.febInstallment,
    required this.marInstallment,
    required this.aprInstallment,
    required this.mayInstallment,
    required this.junInstallment,
    required this.julInstallment,
    required this.augInstallment,
    required this.sepInstallment,
    required this.octInstallment,
    required this.novInstallment,
    required this.decInstallment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleIdRef': vehicleIdRef,
      'janInstallment': janInstallment,
      'febInstallment': febInstallment,
      'marInstallment': marInstallment,
      'aprInstallment': aprInstallment,
      'mayInstallment': mayInstallment,
      'junInstallment': junInstallment,
      'julInstallment': julInstallment,
      'augInstallment': augInstallment,
      'sepInstallment': sepInstallment,
      'octInstallment': octInstallment,
      'novInstallment': novInstallment,
      'decInstallment': decInstallment,
    };
  }

  static VehicleInstallments fromMap(Map<String, dynamic> map) {
    return VehicleInstallments(
      id: map['id'],
      vehicleIdRef: map['vehicleIdRef'],
      janInstallment: map['janInstallment'],
      febInstallment: map['febInstallment'],
      marInstallment: map['marInstallment'],
      aprInstallment: map['aprInstallment'],
      mayInstallment: map['mayInstallment'],
      junInstallment: map['junInstallment'],
      julInstallment: map['julInstallment'],
      augInstallment: map['augInstallment'],
      sepInstallment: map['sepInstallment'],
      octInstallment: map['octInstallment'],
      novInstallment: map['novInstallment'],
      decInstallment: map['decInstallment'],
    );
  }
}
