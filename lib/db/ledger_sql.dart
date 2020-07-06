import 'package:sqflite/sqflite.dart';

class LedgerSqlManager {
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
    await db.execute('''CREATE TABLE TbAccount (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      uuid TEXT UNIQUE,
      name TEXT NOT NULL,
      isDeleted INTEGER AS Boolean NOT NULL DEFAULT 0,
      orderIndex INTEGER NOT NULL DEFAULT 0,
      balance REAL AS BigDecimal NOT NULL DEFAULT 0,
      dueDay INTEGER NOT NULL DEFAULT -1,
      billDay INTEGER NOT NULL DEFAULT -1,
      creditLimit REAL AS BigDecimal NOT NULL DEFAULT 0,
      background TEXT,
      icon TEXT,
      mTime INTEGER NOT NULL DEFAULT 0
    );''');
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

  /// 关闭
  static close() {
    _database?.close();
    _database = null;
  }
}
