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

  String get double_click_hint {
    return Intl.message(
        '双击退出',
        name: "doubleClickHint");
  }

  String get confirm {
    return Intl.message(
        '确认',
        name: "confirm");
  }

  String get property {
    return Intl.message(
        '资产',
        name: "property");
  }

  String get transactions {
    return Intl.message(
        '账单',
        name: "transactions");
  }

  String get statistics {
    return Intl.message(
        '统计',
        name: "statistics");
  }

  String get property_assets {
    return Intl.message(
        '资产',
        name: "property_assets");
  }

  String get property_liabilities {
    return Intl.message(
        '负债',
        name: "property_liabilities");
  }

  String get add_account {
    return Intl.message(
        '添加账户',
        name: "add_account");
  }

  String get select_account_type {
    return Intl.message(
        '选择账户类型',
        name: "select_account_type");
  }

  String get assets_account {
    return Intl.message(
        '资产账户',
        name: "assets_account");
  }

  String get liabilities_account {
    return Intl.message(
        '负债账户',
        name: "liabilities_account");
  }

  create_account(name) {
    return Intl.message(
        '创建$name账户',
        name: "create_account");
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