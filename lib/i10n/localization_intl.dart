import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class LedgerLocalizations {

  static LedgerLocalizations of(BuildContext context) {
    return Localizations.of<LedgerLocalizations>(context, LedgerLocalizations);
  }

  static Future<LedgerLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new LedgerLocalizations();
    });
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});

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