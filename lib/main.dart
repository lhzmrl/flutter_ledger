import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ledger/app/ledger_app.dart';
import 'package:ledger/ui/error/view/error_page.dart';

void main() {
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return ErrorPage(
          details.exception.toString() + "\n " + details.stack.toString(), details);
    };
    runApp(LedgerApp());
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });

}
