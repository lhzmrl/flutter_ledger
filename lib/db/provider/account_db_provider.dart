import 'package:ledger/db/db_provider.dart';
import 'package:ledger/model/Account.dart';
import 'package:ledger/model/AccountType.dart';
import 'package:sqflite/sqflite.dart';

class AccountDbProvider extends BaseDbProvider {

  static const String TABLE_NAME = "table_account";

  static const String COLUMN_ID = "id";
  static const String COLUMN_UUID = "uuid";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_IS_DELETED = "is_deleted";
  static const String COLUMN_ORDER_INDEX = "order_index";
  static const String COLUMN_TYPE_ID = "type_id";
  static const String COLUMN_BALANCE = "balance";
  static const String COLUMN_DUE_DAY = "due_day";
  static const String COLUMN_BILL_DAY = "bill_day";
  static const String COLUMN_CREDIT_LIMIT = "credit_limit";
  static const String COLUMN_BACKGROUND = "background";
  static const String COLUMN_ICON = "icon";
  static const String COLUMN_DEVICE_ID = "device_id";
  static const String COLUMN_M_TIME = "m_time";

  @override
  String tableName() => TABLE_NAME;

  @override
  String tableSqlString() {
    return '''CREATE TABLE $TABLE_NAME (
      $COLUMN_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $COLUMN_UUID TEXT UNIQUE,
      $COLUMN_NAME TEXT NOT NULL,
      $COLUMN_IS_DELETED INTEGER NOT NULL DEFAULT 0,
      $COLUMN_TYPE_ID INTEGER NOT NULL DEFAULT 0,
      $COLUMN_ORDER_INDEX INTEGER NOT NULL DEFAULT 0,
      $COLUMN_BALANCE REAL NOT NULL DEFAULT 0,
      $COLUMN_DUE_DAY INTEGER NOT NULL DEFAULT -1,
      $COLUMN_BILL_DAY INTEGER NOT NULL DEFAULT -1,
      $COLUMN_CREDIT_LIMIT REAL NOT NULL DEFAULT 0,
      $COLUMN_BACKGROUND TEXT,
      $COLUMN_ICON TEXT,
      $COLUMN_DEVICE_ID TEXT,
      $COLUMN_M_TIME INTEGER NOT NULL DEFAULT 0
    );''';
  }

  Future<int> insert(Account account) async {
    Database db = await getDataBase();
    return await db.insert(TABLE_NAME,
        {
          COLUMN_NAME: account.name,
          COLUMN_TYPE_ID: account.type.index,
          COLUMN_BALANCE: account.balance,
          COLUMN_M_TIME: DateTime.now().millisecondsSinceEpoch
        });
  }

  Future<List<Account>> selectByType(AccountType accountType) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(TABLE_NAME,
        where: "$COLUMN_TYPE_ID = ?",
        whereArgs: [accountType.index]);
    List<Account> accounts = new List<Account>();
    maps.forEach((element) {
      Account account = _convertDbMap2Account(element);
      accounts.add(account);
    });
    return accounts;
  }

  Account _convertDbMap2Account(Map<String, dynamic> map) {
    Account account = new Account();
    account.id = map[COLUMN_ID];
    account.uuid = map[COLUMN_UUID];
    account.name = map[COLUMN_NAME];
    account.isDeleted = map[COLUMN_IS_DELETED] == 1 ? true : false;
    account.orderIndex = map[COLUMN_ORDER_INDEX];
    account.type = AccountType.values[map[COLUMN_TYPE_ID]];
    account.balance = map[COLUMN_BALANCE];
    account.dueDay = map[COLUMN_DUE_DAY];
    account.billDay = map[COLUMN_BILL_DAY];
    account.creditLimit = map[COLUMN_CREDIT_LIMIT];
    account.background = map[COLUMN_BACKGROUND];
    account.icon = map[COLUMN_ICON];
    account.deviceId = map[COLUMN_DEVICE_ID];
    account.mTime = map[COLUMN_M_TIME];
    return account;
  }

}