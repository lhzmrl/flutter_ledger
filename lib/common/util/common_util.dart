import 'package:flutter/material.dart';
import 'package:ledger/common/util/navigator_util.dart';

class CommonUtil {

  static Future<Null> showEditDialog(
      BuildContext context,
      String dialogTitle,
      ValueChanged<String> onTitleChanged,
      ValueChanged<String> onContentChanged,
      VoidCallback onPressed, {
        TextEditingController titleController,
        TextEditingController valueController,
        bool needTitle = true,
      }) {
    return NavigatorUtil.showLedgerDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Text("EditDialog"),
          );
        });
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtil.showLedgerDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child:Text("Loading"),
                  ),
                ),
              ));
        });
  }

}