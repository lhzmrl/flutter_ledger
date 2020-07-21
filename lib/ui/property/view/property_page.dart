import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/model/AccountType.dart';
import 'package:ledger/res/ledger_style.dart';
import 'package:ledger/ui/property/view/account_list_page.dart';

class PropertyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PropertyPageState();
  }

}

class _PropertyPageState extends State<PropertyPage> with SingleTickerProviderStateMixin<PropertyPage>, AutomaticKeepAliveClientMixin {

  TabController _tabController;
  List<String> tabs;
  List<Widget> pages = <Widget>[
    AccountListPage(AccountType.assets),
    AccountListPage(AccountType.liabilities),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(null == tabs) {
      tabs = [LedgerLocalizations.of(context).property_assets, LedgerLocalizations.of(context).property_liabilities];
    }
    if(null == _tabController) {
      _tabController = TabController(length: tabs.length, vsync: this);
    }
    return SafeArea(
        child: Scaffold(
          appBar: TabBar(
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            isScrollable: true,
            labelColor: LedgerColors.primaryColor,
            unselectedLabelColor: Colors.black,
            indicatorWeight: 2,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
            controller: _tabController,
          ),
          body: TabBarView(
            controller: _tabController,
            children: pages,
          ),
        )
    );
  }

  @override
  bool get wantKeepAlive => true;

}