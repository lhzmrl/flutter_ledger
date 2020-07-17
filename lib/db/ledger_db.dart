import 'package:sqflite/sqflite.dart';

class LedgerDbManager {
  static const _VERSION = 1;

  static const _NAME = "ledger.db";

  static Database _database;

  /// 初始化
  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/" + _NAME;
    _database = await openDatabase(path, version: _VERSION,
        onCreate: initTables,
        onUpgrade: upgradeTables);
  }

  static void initTables(Database db, int version) async {
    // When creating the db, create the table
  }

  static void upgradeTables(Database db, int oldVersion, int newVersion) async {

  }

  /// 获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  /// 表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  /// 关闭
  static close() {
    _database?.close();
    _database = null;
  }

}