
import 'package:flutter/material.dart';
import 'package:ledger/i10n/localization_intl.dart';
import 'package:ledger/ui/common/view/amount_keyboard.dart';
import 'package:ledger/ui/common/view/ledger_app_bar.dart';

class EditTextPage extends StatefulWidget {

  EditTextPage(this.title, {this.value, this.textInputType});

  final String title;
  final String value;
  final TextInputType textInputType;

  @override
  State<StatefulWidget> createState() {
    return _EditTextPageState();
  }

}

class _EditTextPageState extends State<EditTextPage> implements OnAmountChangedListener {

  final TextEditingController _contentTextController = TextEditingController();
  String expression;

  @override
  void initState() {
    super.initState();
    String initValue;
    if(null == widget.textInputType) {
      initValue = this.widget.value??"0.00";
    } else {
      initValue = this.widget.value??"";
    }
    _contentTextController.text = initValue;
  }

  @override
  Widget build(BuildContext context) {
    Widget textField;
    if(null == widget.textInputType) {
      textField = TextField(
        textAlign: TextAlign.end,
        maxLines: 1,
        enabled: false,
        controller: _contentTextController,
      );
    } else {
      textField = TextField(
        textAlign: TextAlign.end,
        maxLines: 1,
        autofocus: true,
        keyboardType: widget.textInputType,
        controller: _contentTextController,
      );
    }
    List<Widget> content;
    if(null == widget.textInputType) {
      content = [
        textField,
        Text(expression??"",
          textAlign: TextAlign.end,
        ),
        Spacer(),
        AmountKeyboard(onAmountChangedListener: this,)
      ];
    } else {
      content = [
        textField,
      ];
    }
    return Scaffold(
      appBar: LedgerAppBar(widget.title??"", actions: [
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: content,
      ),
    );
  }

  @override
  void onAmountChanged(double amount) {
    _contentTextController.text = _formatAmountStr(amount.toString());
  }

  @override
  void onExpressionChanged(String expression) {
    setState(() {
      final RegExp operation = new RegExp("[+\\-*/]()");
      if(operation.hasMatch(expression)) {
        this.expression = expression;
      } else {
        _contentTextController.text = _formatAmountStr(double.parse(expression.isEmpty?"0":expression).toString());
        this.expression = "";
      }
    });
  }

  String _formatAmountStr(String amountStr) {
    int index = amountStr.lastIndexOf(".");
    if(-1 == index) {
      amountStr = amountStr + '.00';
    } else if(amountStr.length - 1 - index < 2) {
      int count = amountStr.length - 1 - index;
      for(int i = 0; i < count; i++) {
        amountStr = amountStr + '0';
      }
    }
    return amountStr;
  }

}