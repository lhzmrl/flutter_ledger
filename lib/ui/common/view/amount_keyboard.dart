
import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/res/ledger_style.dart';
import 'package:ledger/util/calculator.dart';

class AmountKeyboard extends StatefulWidget {

  AmountKeyboard({this.precision = 2, this.onAmountChangedListener});

  final int precision;
  final OnAmountChangedListener onAmountChangedListener;

  @override
  State<StatefulWidget> createState() {
    return _AmountKeyboardState();
  }

}

class _AmountKeyboardState extends State<AmountKeyboard> {

  String _expression = "";
  double _amount;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "7", onTap: () => press(KeyAction.Num7)),
              _HorizontalDivider(),
              _Key(text: "8", onTap: () => press(KeyAction.Num8)),
              _HorizontalDivider(),
              _Key(text: "9", onTap: () => press(KeyAction.Num9)),
              _HorizontalDivider(),
              _Key(iconData: Icons.backspace, onTap: () => press(KeyAction.Delete))
            ],
          ),
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "4", onTap: () => press(KeyAction.Num4)),
              _HorizontalDivider(),
              _Key(text: "5", onTap: () => press(KeyAction.Num5)),
              _HorizontalDivider(),
              _Key(text: "6", onTap: () => press(KeyAction.Num6)),
              _HorizontalDivider(),
              _Key(text: "+", onTap: () => press(KeyAction.Plus))
            ],
          ),
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "1", onTap: () => press(KeyAction.Num1)),
              _HorizontalDivider(),
              _Key(text: "2", onTap: () => press(KeyAction.Num2)),
              _HorizontalDivider(),
              _Key(text: "3", onTap: () => press(KeyAction.Num3)),
              _HorizontalDivider(),
              _Key(text: "-", onTap: () => press(KeyAction.Minus))
            ],
          ),
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "C", onTap: () => press(KeyAction.Clear)),
              _HorizontalDivider(),
              _Key(text: "0", onTap: () => press(KeyAction.Num0)),
              _HorizontalDivider(),
              _Key(text: ".", onTap: () => press(KeyAction.Point)),
              _HorizontalDivider(),
              _Key(text: LedgerLocalizations.of(context).confirm, onTap: () => press(KeyAction.Confirm))
            ],
          ),
        ],
    );
  }

  void press(KeyAction action) {
    switch(action) {
      case KeyAction.Num0:
        continueExpression("0");
        break;
      case KeyAction.Num1:
        continueExpression("1");
        break;
      case KeyAction.Num2:
        continueExpression("2");
        break;
      case KeyAction.Num3:
        continueExpression("3");
        break;
      case KeyAction.Num4:
        continueExpression("4");
        break;
      case KeyAction.Num5:
        continueExpression("5");
        break;
      case KeyAction.Num6:
        continueExpression("6");
        break;
      case KeyAction.Num7:
        continueExpression("7");
        break;
      case KeyAction.Num8:
        continueExpression("8");
        break;
      case KeyAction.Num9:
        continueExpression("9");
        break;
      case KeyAction.Point:
        continueExpression(".");
        break;
      case KeyAction.Plus:
        continueExpression("+");
        break;
      case KeyAction.Minus:
        continueExpression("-");
        break;
      case KeyAction.Delete:
        if(_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
          onExpressionChanged(_expression);
        }
        break;
      case KeyAction.Clear:
        _expression = "";
        onExpressionChanged(_expression);
        break;
      case KeyAction.Confirm:
        _amount = Calculator.tryCalculate(_expression);
        onAmountChanged(_amount);
        _expression = _amount.toString();
        onExpressionChanged(_expression);
        break;
    }

  }

  void continueExpression(String char) {
    if(_expression.isEmpty) {
      _expression = char;
      onExpressionChanged(_expression);
      return;
    }
    if(char == ".") {
      if(_expression[_expression.length - 1] == ".") {
        return;
      }
    }
    String lastOperandString = Calculator.getLastOperandString(_expression);
    final RegExp operation = new RegExp("[+\\-*/]");
    bool isTheLstOperandAnOperator = operation.hasMatch(lastOperandString);
    if(isTheLstOperandAnOperator) {
      if(operation.hasMatch(char)) {
        _expression = _expression.substring(0, _expression.length - 1) + char;
      } else {
        _expression = _expression + char;
      }
    } else {
      if(!operation.hasMatch(char)) {
        int pointIndex = lastOperandString.lastIndexOf(".");
        if(pointIndex != -1) {
          if(char == ".") {
            return;
          }
          if((lastOperandString.length - 1 - pointIndex) >= widget.precision) {
            return;
          }
        }
      }
      _expression = _expression + char;
    }
    onExpressionChanged(_expression);
  }

  void onAmountChanged(double amount) {
    if(null != this.widget.onAmountChangedListener) {
      this.widget.onAmountChangedListener.onAmountChanged(amount);
    }
  }

  void onExpressionChanged(String expression) {
    if(null != this.widget.onAmountChangedListener) {
      this.widget.onAmountChangedListener.onExpressionChanged(expression);
    }
  }

}

class _Key extends StatelessWidget {

  _Key({this.text, this.iconData, this.onTap});

  final GestureTapCallback onTap;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if(null != text) {
      content = Text(text);
    } else {
      content = Icon(iconData);
    }
    return Expanded(
      flex: 1,
      child: MaterialButton(
          height: 48,
          onPressed: () => {
            if(null != onTap) {
              onTap()
            }
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))
          ),
          color: Colors.white,
          highlightColor: LedgerColors.lightPageBackground,
          elevation: 0,
          child: content
      ),
    );
  }

}

enum KeyAction {
  Num0,
  Num1,
  Num2,
  Num3,
  Num4,
  Num5,
  Num6,
  Num7,
  Num8,
  Num9,
  Point,
  Delete,
  Plus,
  Minus,
  Clear,
  Confirm
}

class _HorizontalDivider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LedgerColors.lightPageBackground,
      width: 0.5,
      height: 48,
    );
  }

}

class  OnAmountChangedListener {

  void onAmountChanged(double amount) => throw UnimplementedError();
  void onExpressionChanged(String expression) => throw UnimplementedError();

}

