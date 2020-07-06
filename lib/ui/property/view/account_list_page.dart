import 'package:flutter/cupertino.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/model/AccountType.dart';

class AccountListPage extends StatefulWidget {

  AccountListPage(this.accountType);

  final AccountType accountType;

  @override
  State<StatefulWidget> createState() {
    return _AccountListPageState();
  }

}

class _AccountListPageState extends State<AccountListPage> {

  @override
  Widget build(BuildContext context) {
    String accountType;
    switch(widget.accountType) {
      case AccountType.assets:
        accountType = LedgerLocalizations.of(context).property_assets;
        break;
      case AccountType.liabilities:
        accountType = LedgerLocalizations.of(context).property_liabilities;
        break;
    }
    Widget header = Container(
      constraints: BoxConstraints(
          minWidth: double.infinity
      ),
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(accountType),
          Expanded(
            child: Column(
              children: <Widget>[
                Text("1010101"),
                Text("1010101")
              ],
            ),
          ),
        ],
      ),
    );
    Widget footer = Container(
      child: Text("添加账户"),
    );
    return ListView(
      children: [
        header,
        footer,
      ],
    );
  }

}