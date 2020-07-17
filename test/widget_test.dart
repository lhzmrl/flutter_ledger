// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger/db/provider/account_db_provider.dart';
import 'package:ledger/model/Account.dart';
import 'package:ledger/model/AccountType.dart';
import 'package:ledger/ui/transaction/view/transactions_page.dart';

void main() {
  testWidgets('Test flutter test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(WrapperPage(TransactionsPage()));

    // Verify that our counter starts at 0.
    expect(find.text('This is TransactionsPage'), findsOneWidget);

  });
}

class WrapperPage extends StatelessWidget {

  WrapperPage(this.home);

  Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home,
    );
  }



}