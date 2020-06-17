import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class LedgerLocalizations {

  static LedgerLocalizations of(BuildContext context) {
    return Localizations.of<LedgerLocalizations>(context, LedgerLocalizations);
  }

  static Future<LedgerLocalizations> load(Locale locale) {
    final String name = (locale.countryCode == null|| locale.countryCode.isEmpty) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new LedgerLocalizations();
    });
  }

  String get title {
    return Intl.message(
      'Keep记账',
      name: 'title',
      desc: '应用标题',
    );
  }

  String get doubleClickHint {
    return Intl.message(
        '双击退出',
        name: "doubleClickHint");
  }

}

class LedgerLocalizationsDelegate extends LocalizationsDelegate<LedgerLocalizations> {

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<LedgerLocalizations> load(Locale locale) {
    return LedgerLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<LedgerLocalizations> old) => false;

}