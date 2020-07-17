import 'package:flutter/material.dart';
import 'package:ledger/app/router.dart';
import 'package:ledger/db/provider/account_db_provider.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/model/Account.dart';
import 'package:ledger/model/AccountTemplate.dart';
import 'package:ledger/model/AccountType.dart';
import 'package:ledger/res/ledger_style.dart';
import 'package:ledger/ui/common/view/ledger_app_bar.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage(this.accountTemplate);

  final AccountTemplate accountTemplate;

  @override
  State<StatefulWidget> createState() {
    return _CreateAccountPageState();
  }
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  String name;
  String amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LedgerAppBar(LedgerLocalizations.of(context).create_account(widget.accountTemplate.name),
          actions: [
            GestureDetector(
              onTap: _onConfirm,
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(LedgerLocalizations.of(context).confirm),
                ),
              ),
            )
          ]
      ),
      body: Container(
        color: LedgerColors.lightPageBackground,
        child: Column(
          children: [
            SizedBox(height: 32),
            MaterialButton(
              padding: EdgeInsets.all(0),
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              height: 56,
              color: Colors.white,
              onPressed: () => Navigator.pushNamed(context, Router.editText, arguments: {
                "title": LedgerLocalizations.of(context).edit_account_name,
                "value": name,
                "type": TextInputType.name})
                  .then((value) {
                    if(null != value) {
                      setState(() => this.name = value);
                    }
                  }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text(LedgerLocalizations.of(context).account_name),
                    Spacer(),
                    Text(name??""),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(height: 1),
            MaterialButton(
              padding: EdgeInsets.all(0),
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              height: 56,
              color: Colors.white,
              onPressed: () => Navigator.pushNamed(context, Router.editText, arguments: {
                "title": LedgerLocalizations.of(context).edit_account_amount,
                "value": amount
              })
                  .then((value) => setState(() => this.amount = value)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text(LedgerLocalizations.of(context).account_amount),
                    Spacer(),
                    Text(amount??""),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(height: 1),
            MaterialButton(
              padding: EdgeInsets.all(0),
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              height: 56,
              color: Colors.white,
              onPressed: () => {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text("选择账户颜色"),
                    Spacer(),
                    Text(""),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onConfirm() {
    _createAccount();
  }

  void _createAccount() {
    AccountDbProvider accountDbProvider = new AccountDbProvider();
    Account account = new Account();
    account.name = name;
    account.type = widget.accountTemplate.accountType;
    account.balance = double.parse(amount) * (widget.accountTemplate.accountType == AccountType.assets ? 1 : -1);
    Future future = accountDbProvider.insert(account);
    future.then((value) {
      Navigator.pop<bool>(context, true);
    });
  }
}
