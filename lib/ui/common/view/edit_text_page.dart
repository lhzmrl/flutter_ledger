
import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/ui/common/view/amount_keyboard.dart';
import 'package:ledger/ui/common/view/ledger_app_bar.dart';

class EditTextPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _EditTextPageState();
  }

}

class _EditTextPageState extends State<EditTextPage> {

  final TextEditingController _contentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations a;
    return Scaffold(
      appBar: LedgerAppBar("title", actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context, _contentTextController.text),
          child: Padding(
          padding: EdgeInsets.only(right: 16),
          child: Center(
            child: Text(LedgerLocalizations.of(context).confirm),
          ),
        ),
        )
      ],),
      body: Column(
        children: [
          TextField(
            controller: _contentTextController,
          ),
          Spacer(),
          AmountKeyboard()
        ],
      ),
    );
  }

}