import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/res/ledger_style.dart';
import 'package:ledger/ui/property/view/property_page.dart';
import 'package:ledger/ui/statistics/view/statistics_page.dart';
import 'package:ledger/ui/transaction/view/transactions_page.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> {

  PageController _controller; //页面控制器，初始0
  List<Widget> pages = <Widget>[
    TransactionsPage(),
    PropertyPage(),
    StatisticsPage(),
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //释放控制器
  }

  @override
  Widget build(BuildContext context) {
    return _WillPopScope(Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: pages,
        ),
        bottomNavigationBar: BottomAppBar(
            elevation: 2,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _createTab(1, LedgerLocalizations.of(context).property, Icon(LedgerIcons.NAVI_PROPERTY)),
                _createTab(0, LedgerLocalizations.of(context).transactions, Icon(LedgerIcons.NAVI_TRANS)),
                _createTab(2, LedgerLocalizations.of(context).statistics, Icon(LedgerIcons.NAVI_STATISTICS)),
              ],
            )
        )
      )
    );
  }

  Widget _createTab(int index, String text, Icon icon) {
    return GestureDetector(
      onTap: () {_navigationTapClick(index);},
      child: Tab(text: text, icon: icon),
    );
  }

  _navigationTapClick(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    ///不想要动画
    _controller.jumpTo(MediaQuery.of(context).size.width * index);
  }

}

class _WillPopScope extends StatefulWidget {

  final Widget _child;

  _WillPopScope(this._child);

  @override
  _WillPopScopeTestRouteState createState() {
    return new _WillPopScopeTestRouteState();
  }
}

class _WillPopScopeTestRouteState extends State<_WillPopScope> {

  DateTime _lastPressedAt; //上次点击时间

  _WillPopScopeTestRouteState();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            _showDoubleClickHint();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: widget._child,
        ));
  }

  _showDoubleClickHint() {
    final snackBar = SnackBar(
      content: Text(LedgerLocalizations.of(context).doubleClickHint),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
