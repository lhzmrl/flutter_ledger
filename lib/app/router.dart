import 'package:flutter/material.dart';
import 'package:ledger/ui/common/view/edit_text_page.dart';
import 'package:ledger/ui/main/view/home_page.dart';
import 'package:ledger/ui/property/view/account_template_list_page.dart';
import 'package:ledger/ui/property/view/create_account_page.dart';
import 'package:ledger/ui/transaction/view/add_new_trans_page.dart';
import 'package:ledger/util/router_utils.dart';

class Router {

  static const home = "/";
  static const editText = "common/text/edit";
  static const addNewTransaction = "trans/add";
  static const listAccountTemplates = "account/template/list";
  static const createAccount = "account/create";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return Right2LeftRouter(child: HomePage());
      case editText:
        return Right2LeftRouter(child: EditTextPage());
      case addNewTransaction:
        return Right2LeftRouter(child: AddNewTransactionPage());
      case listAccountTemplates:
        return Right2LeftRouter(child: AccountTemplateListPage());
      case createAccount:
        return Right2LeftRouter(child: CreateAccountPage(settings.arguments));
        break;
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