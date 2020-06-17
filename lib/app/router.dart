import 'package:flutter/material.dart';
import 'file:///D:/Workspace/github/flutter_ledger/lib/ui/main/view/home_page.dart';
import 'file:///D:/Workspace/github/flutter_ledger/lib/ui/transaction/view/add_new_trans_page.dart';
import 'package:ledger/util/router_utils.dart';

class Router {

  static const home = "/";
  static const addNewTransaction = "trans/add";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return Right2LeftRouter(child: HomePage());
      case addNewTransaction:
        return Right2LeftRouter(child: AddNewTransactionPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }

}