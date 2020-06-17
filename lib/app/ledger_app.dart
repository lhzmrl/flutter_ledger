import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ledger/app/router.dart';
import 'package:ledger/i10n/localization_intl.dart';


class LedgerApp extends StatelessWidget {
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
      onGenerateRoute: Router.generateRoute,
    );
  }
}