import 'package:flutter/material.dart';
import 'package:ledger/db/ledger_db.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDbProvider {

  bool isTableExits = false;

  String tableName();

  String tableSqlString();

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await LedgerDbManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await LedgerDbManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  Future<Database> open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await LedgerDbManager.getCurrentDatabase();
  }

}