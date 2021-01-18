import 'package:ocr_mobile/src/models/loginResponse.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String Token = 'token';
  static const String Message = 'message';
  static const String AppicationSubscriberName = 'appicationSubscriberName';
  static const String ApplicationUserEmail = 'applicationUserEmail';
  static const String ApplicationUserFirstName = 'applicationUserFirstName';
  static const String ApplicationUserLast = 'applicationUserLast';
  static const String ApplicationUserPhoneNumber = 'applicationUserPhoneNumber';
  static const String TABLE = 'LoginResponse';
  static const String DB_NAME = 'loginResponse.db';

  //return db if initialized else initialized it
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
    "CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY, $Token TEXT, $Message TEXT, $AppicationSubscriberName TEXT, $ApplicationUserEmail TEXT, $ApplicationUserFirstName TEXT, $ApplicationUserLast TEXT, $ApplicationUserPhoneNumber TEXT)");
  }

  Future<LoginResponse> insertToDb(LoginResponse _response) async {
    var dbClient = await db;
    //insert will return the id
    var insert = await dbClient.insert(TABLE, _response.toJson());
    return _response;
  }

  Future<LoginResponse> getResponse() async {
    var dbClient = await db;
    var data = await dbClient.query(TABLE, columns: [
      ID,
      Token,
      Message,
      AppicationSubscriberName,
      ApplicationUserEmail,
      ApplicationUserFirstName,
      ApplicationUserLast,
      ApplicationUserPhoneNumber
    ]);
    var res = LoginResponse.fromJson(data.last);
    return res;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future deleteTable() async {
    var dbClient = await db;
    return await dbClient.delete(TABLE);
  }
}
