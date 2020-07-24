import 'package:flutter/material.dart';

class TransListHeader extends StatefulWidget {
  @override
  _TransListHeaderState createState() => _TransListHeaderState();
}

class _TransListHeaderState extends State<TransListHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text("x月收入"),
                Text("0.00"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text("月预算"),
                Text("1000.00")
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text("x月支出"),
                Text("0.00"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
