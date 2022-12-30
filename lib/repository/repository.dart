import 'database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  DatabaseConnection? _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _databaseConnection!.setDatabase();
    return _database!;
  }

  //Inserting data to Table
  insertData(table, data)async{
    var connection = await database;
    return await connection.insert(table, data);
  }
}