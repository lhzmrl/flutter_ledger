import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/ui/transaction/view/add_new_trans_page.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> {

  PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return _WillPopScope(Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          AddNewTransactionPage(),
          AddNewTransactionPage(),
          AddNewTransactionPage(),
        ],
      ),
      bottomNavigationBar: _HomePageBottomBar())
    );
  }

}

class _HomePageBottomBar extends StatefulWidget {

  final Color color = Colors.white;

  @override
  State<StatefulWidget> createState() {
    return _HomePageBottomBarState();
  }
}

class _HomePageBottomBarState extends State<_HomePageBottomBar> {

  final borderTR = const BorderRadius.only(topRight: Radius.circular(10));
  final borderTL = const BorderRadius.only(topLeft: Radius.circular(10));
  final paddingTR = const EdgeInsets.only(top: 2, right: 2);
  final paddingTL = const EdgeInsets.only(top: 2, left: 2);

  int _position = 0;
  List<String> info = ["A", "B", "C"];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 2,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: info
            .map((e) => _buildChild(context, info.indexOf(e), widget.color))
            .toList(),
      )
    );
  }

  Widget _buildChild(BuildContext context, int i, Color color) {
    var active = i == _position;
    bool left = i == 0;

    return GestureDetector(
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: left ? borderTR : borderTL),
        child: Container(
            margin: left ? paddingTR : paddingTL,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.withAlpha(88),
                borderRadius: left ? borderTR : borderTL),
            height: 45,
            width: 100,
            child: Icon(
              Icons.home,
              color: active ? color : Colors.white,
              size: active ? 28 : 24,
            )),
      ),
    );
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
