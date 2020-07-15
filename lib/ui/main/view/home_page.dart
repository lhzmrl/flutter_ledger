import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ledger/app/router.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController; //页面控制器，初始0
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  List<Widget> pages = <Widget>[
    TransactionsPage(),
    PropertyPage(),
    StatisticsPage(),
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose(); //释放控制器
  }

  @override
  Widget build(BuildContext context) {
    return _WillPopScope(
      Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: pages,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          color: Colors.white,
          child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _createTab(1, LedgerLocalizations.of(context).property,
                      LedgerIcons.NAVI_PROPERTY),
                  _createTab(0, LedgerLocalizations.of(context).transactions,
                      LedgerIcons.NAVI_TRANS),
                  _createTab(2, LedgerLocalizations.of(context).statistics,
                      LedgerIcons.NAVI_STATISTICS),
                ],
              )),
        )
      )
    );
  }

  Widget _createTab(int index, String text, IconData iconData) {
    Color tabColor = index == _index ? Colors.blue : Colors.grey;
    if (index == 0) {
      return Expanded(
        flex: 1,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _navigationTapClick(index);
          },
          child: AnimatedCrossFadeRotate(
            firstCurve: Curves.easeInCirc,
            secondCurve: Curves.easeInToLinear,
            sizeCurve: Curves.bounceOut,
            crossFadeState: _crossFadeState,
            duration: Duration(milliseconds: 300),
            firstChild: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      LedgerIcons.NAVI_ADD_TRANS,
                      size: 36,
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.only(bottom: 6.0),
                  ),
                ],
              ),
            ),
            secondChild: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(
                      iconData,
                      color: tabColor,
                    ),
                    margin: EdgeInsets.only(bottom: 4.0),
                  ),
                  Text(
                    text,
                    textScaleFactor: 0.8,
                    style: TextStyle(color: tabColor),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _navigationTapClick(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  iconData,
                  color: tabColor,
                ),
                margin: EdgeInsets.only(bottom: 4.0),
              ),
              Text(
                text,
                textScaleFactor: 0.8,
                style: TextStyle(color: tabColor),
              )
            ],
          ),
        ),
      );
    }
  }

  _navigationTapClick(index) {
    if (_index == index) {
      if (_index == 0) {
        Navigator.pushNamed(context, Router.addNewTransaction);
      }
      return;
    }
    _pageController.jumpTo(MediaQuery.of(context).size.width * index);
    setState(() {
      _index = index;
      _crossFadeState =
          _index == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }
}

class AnimatedCrossFadeRotate extends ImplicitlyAnimatedWidget {

  const AnimatedCrossFadeRotate({Key key,
  @required this.firstChild,
  @required this.secondChild,
  this.firstCurve = Curves.linear,
  this.secondCurve = Curves.linear,
  this.sizeCurve = Curves.linear,
  this.alignment = Alignment.topCenter,
  @required this.crossFadeState,
  @required this.duration}): super(key: key, duration: duration);

  final Widget firstChild;
  final Widget secondChild;
  final CrossFadeState crossFadeState;
  final Duration duration;
  final Curve firstCurve;
  final Curve secondCurve;
  final Curve sizeCurve;
  final AlignmentGeometry alignment;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return new _AnimatedCrossFadeRotateState();
  }

}

class _AnimatedCrossFadeRotateState extends AnimatedWidgetBaseState<AnimatedCrossFadeRotate> {

  Tween<double> _tweenFirst;
  Tween<double> _tweenSecond;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    // 在需要更新Tween时，基类会调用此方法
    _tweenFirst = visitor(_tweenFirst, widget.crossFadeState == CrossFadeState.showFirst ? 1.0 : 0.0,
            (value) {
              return Tween<double>(begin: value);
            });
    _tweenSecond = visitor(_tweenSecond, widget.crossFadeState == CrossFadeState.showFirst ? 0.0 : 1.0,
            (value) {
          return Tween<double>(begin: value);
        });
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: controller,
      child: Stack(
        alignment: Alignment.center,
        children : <Widget>[
          ScaleTransition(
            scale: _tweenFirst.animate(controller),
            child: FadeTransition(
              opacity: _tweenFirst.animate(controller),
              child: widget.firstChild,
            ),
          ),
          ScaleTransition(
            scale: _tweenSecond.animate(controller),
            child: FadeTransition(
              opacity: _tweenSecond.animate(controller),
              child: widget.secondChild,
            ),
          )
        ],
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
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 2)) {
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
    FlutterToast(context).showToast(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(3)),
          child: Text(LedgerLocalizations.of(context).double_click_hint,
            style: TextStyle(color: Colors.white),
          ),
        ),
        toastDuration: Duration(seconds: 2),
        gravity: ToastGravity.CENTER
    );
  }
}
