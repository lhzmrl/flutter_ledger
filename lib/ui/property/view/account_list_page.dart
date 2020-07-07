import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/model/Account.dart';
import 'package:ledger/model/AccountType.dart';
import 'package:ledger/res/ledger_style.dart';
import 'package:ledger/util/localization_utils.dart';

class AccountListPage extends StatefulWidget {

  AccountListPage(this.accountType);

  final AccountType accountType;

  @override
  State<StatefulWidget> createState() {
    return _AccountListPageState();
  }

}

class _AccountListPageState extends State<AccountListPage> {

  double _propertyAmount = 0.0;
  double _netAssetAmount = 0.0;
  List<Account> accounts = [
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
    Account(),
  ];

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
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black12, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: Row(
        children: <Widget>[
          Text(accountType,
            textScaleFactor: 1.4,
          ),
          Spacer(
            flex: 1,
          ),
          Column(
            children: <Widget>[
              Text(formatAmount(_propertyAmount),
                textScaleFactor: 1.2,
                style: TextStyle(color: LedgerColors.primaryColor),
              ),
              Text(formatAmount(_netAssetAmount)),
            ],
          )
        ],
      ),
    );
    Widget footer = Container(
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black12, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: Row(
        children: <Widget>[
          Icon(Icons.add),
          Text(LedgerLocalizations.of(context).add_account),
        ],
      ),
    );
    List<Widget> children = [];
    children.add(header);
    children.addAll(accounts.map((e) => generateAccountWidget(e)));
    children.add(footer);
    return ListView(
      children: children,
    );
  }

  Widget generateAccountWidget(Account account) {
    Widget background = Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: <Widget>[
          Container(
            height: 56,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)
                  ),
                )
            ),
          )
        ],
      ),
    );
    Widget accountInfo = Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(Icons.camera, color: Colors.white,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("现金", textScaleFactor: 1.3,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              Text("现金余额",
                style: TextStyle(
                    color: Colors.white70
                ),
              )
            ],
          ),
          Spacer(),
          Text(formatAmount(123456.78),
            textScaleFactor: 1.2,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
    return Stack(
      children: <Widget>[
        background,
        accountInfo,
      ],
    );
  }

}

class AAA extends Gradient {
  @override
  Shader createShader(Rect rect, {TextDirection textDirection}) {
    // TODO: implement createShader
    throw UnimplementedError();
  }

  @override
  Gradient scale(double factor) {
    // TODO: implement scale
    throw UnimplementedError();
  }

}