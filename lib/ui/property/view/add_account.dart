import 'package:flutter/material.dart';
import 'package:ledger/ui/common/view/ledger_app_bar.dart';

class AddAccountPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AddAccountPageState();
  }

}

class _AddAccountPageState extends State<AddAccountPage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(generateAccountTypeTitle("资产账户"));
    items.add(generateAccountTypeTitle("负债账户"));

    return Scaffold(
      appBar: LedgerAppBar("选择账户类型"),
      body: ListView(
        children: items,
      ),
    );
  }

  Widget generateAccountTypeTitle(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Text(title),
    );
  }

}