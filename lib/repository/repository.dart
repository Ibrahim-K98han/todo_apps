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

  //Read data from Table
  readData(table)async{
    var connection = await database;
    return await connection.query(table);
  }

  //Read data from table by Id
  readDataById(table, itemId) async{
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Update data from table
  updateData(table, data) async{
    var connection = await database;
    return await connection.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }

  //delete data form table
  deleteData(table, itemId) async{
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }
}