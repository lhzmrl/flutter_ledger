import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger/db/provider/account_db_provider.dart';
import 'package:ledger/model/Account.dart';
import 'package:ledger/model/AccountType.dart';

void main() {
  enableFlutterDriverExtension();
  testWidgets('测试Account数据库存储', (WidgetTester tester) async {
    AccountDbProvider accountDbProvider = new AccountDbProvider();
    Account accountCash = Account();
    accountCash.type = AccountType.assets;
    await accountDbProvider.insert(accountCash);
//    List<Account> list = await accountDbProvider.selectByType(
//        AccountType.assets);
//    list.forEach((element) {
//      print("${element.name}");
//    });
  });
}