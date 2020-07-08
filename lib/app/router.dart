import 'package:flutter/material.dart';
import 'package:ledger/ui/main/view/home_page.dart';
import 'package:ledger/ui/property/view/add_account.dart';
import 'package:ledger/ui/transaction/view/add_new_trans_page.dart';
import 'package:ledger/util/router_utils.dart';

class Router {

  static const home = "/";
  static const addNewTransaction = "trans/add";
  static const addAccount = "account/add";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return Right2LeftRouter(child: HomePage());
      case addNewTransaction:
        return Right2LeftRouter(child: AddNewTransactionPage());
      case addAccount:
        return Right2LeftRouter(child: AddAccountPage());
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