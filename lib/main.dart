import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ledger/ui/main/HomePage.dart';
import 'package:ledger/ui/transaction/AddNewTransactionPage.dart';

import 'i10n/localization_intl.dart';

void main() {
  runApp(Ledger());
}

class Ledger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ledger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        LedgerLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh'), // Chinese
        const Locale('en', 'US'), // English
      ],
      routes: {
        "/":(context) => HomePage(),
        "trans/add":(context) => AddNewTransactionPage(),
      },
    );
  }
}