import 'package:flutter/material.dart';
import 'package:ledger/app/router.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/model/AccountTemplate.dart';
import 'package:ledger/res/ledger_style.dart';
import 'package:ledger/ui/common/view/ledger_app_bar.dart';

class AccountTemplateListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AccountTemplateListPageState();
  }

}

class _AccountTemplateListPageState extends State<AccountTemplateListPage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(generateAccountTypeTitle(LedgerLocalizations.of(context).assets_account));
    items.addAll(ASSETS_ACCOUNT_TEMPLATES.map((e) => generateAccountTemplate(e)).toList());
    items.add(generateAccountTypeTitle(LedgerLocalizations.of(context).liabilities_account));
    items.addAll(LIABILITIES_ACCOUNT_TEMPLATES.map((e) => generateAccountTemplate(e)).toList());

    Widget divider = Divider(color: Colors.grey, height: 1,);

    return Scaffold(
      appBar: LedgerAppBar(LedgerLocalizations.of(context).select_account_type),
      body: ListView.separated(
        itemCount: items.length,
        //列表项构造器
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          if(index == 0 ||
              index == ASSETS_ACCOUNT_TEMPLATES.length ||
              index == ASSETS_ACCOUNT_TEMPLATES.length + 1 ||
              index == ASSETS_ACCOUNT_TEMPLATES.length + LIABILITIES_ACCOUNT_TEMPLATES.length + 1) {
            return Divider(color: Colors.transparent, height: 0);
          } else {
            return divider;
          }
        },
      ),
    );
  }

  Widget generateAccountTypeTitle(String title) {
    return Container(
      height: 48,
      color: LedgerColors.lightPageBackground,
      padding: EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.centerLeft,
      child: Text(title),
    );
  }

  Widget generateAccountTemplate(AccountTemplate accountTemplate) {
    List<Widget> title = [Text(accountTemplate.name, textScaleFactor: 1.0,)];
    if(null != accountTemplate.desc) {
      title.add(Text(accountTemplate.desc,
        textScaleFactor: 0.8,
        style: TextStyle(color: Colors.grey),
      ));
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Router.createAccount, arguments: accountTemplate)
            .then((value) {
              if(null == value) {
                return;
              }
              Navigator.pop(context, true);
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        width: double.infinity,
        height: 56,
        child: Row(
          children: [
            Icon(Icons.album),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: title,
              ),
            )
          ],
        ),
      ),
    );
  }

}