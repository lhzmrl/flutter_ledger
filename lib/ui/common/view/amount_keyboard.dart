
import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/res/ledger_style.dart';

class AmountKeyboard extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AmountKeyboardState();
  }

}

class _AmountKeyboardState extends State<AmountKeyboard> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "7"),
              _HorizontalDivider(),
              _Key(text: "8"),
              _HorizontalDivider(),
              _Key(text: "9"),
              _HorizontalDivider(),
              _Key(iconData: Icons.backspace)
            ],
          ),
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "4"),
              _HorizontalDivider(),
              _Key(text: "5"),
              _HorizontalDivider(),
              _Key(text: "6"),
              _HorizontalDivider(),
              _Key(iconData: Icons.add)
            ],
          ),
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "1"),
              _HorizontalDivider(),
              _Key(text: "2"),
              _HorizontalDivider(),
              _Key(text: "3"),
              _HorizontalDivider(),
              _Key(iconData: Icons.trending_flat)
            ],
          ),
          Divider(color: LedgerColors.lightPageBackground, height: 0.5),
          Row(
            children: [
              _Key(text: "C"),
              _HorizontalDivider(),
              _Key(text: "0"),
              _HorizontalDivider(),
              _Key(text: "."),
              _HorizontalDivider(),
              _Key(text: LedgerLocalizations.of(context).confirm)
            ],
          ),
        ],
    );
  }

}

class _Key extends StatelessWidget {

  _Key({this.text, this.iconData});

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
        onPressed: () => {},
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

