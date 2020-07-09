import 'package:flutter/material.dart';
import 'package:ledger/app/router.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/model/AccountTemplate.dart';
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
      appBar: LedgerAppBar(LedgerLocalizations.of(context).create_account(widget.accountTemplate.name)),
      body: Container(
        color: LedgerColors.lightPageBackground,
        child: Column(
          children: [
            SizedBox(height: 32),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.pushNamed(context, Router.editText)
                  .then((value) => setState(() => this.name = value)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: 56,
                color: Colors.white,
                child: Row(
                  children: [
                    Text("账户名称"),
                    Spacer(),
                    Text(name??""),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(height: 1),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: 56,
                color: Colors.white,
                child: Row(
                  children: [
                    Text("金额"),
                    Spacer(),
                    Text(amount??""),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(height: 1),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: 56,
                color: Colors.white,
                child: Row(
                  children: [
                    Text("选择账户颜色"),
                    Spacer(),
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
}
