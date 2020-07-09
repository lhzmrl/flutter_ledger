import 'package:ledger/model/AccountType.dart';

class AccountTemplate {

  const AccountTemplate(this.accountType, this.name, {this.desc = null});

  final AccountType accountType;
  final String name;
  final String desc;
}

const List<AccountTemplate> ASSETS_ACCOUNT_TEMPLATES = <AccountTemplate>[
  AccountTemplate(AccountType.assets, "现金"),
  AccountTemplate(AccountType.assets, "储蓄卡"),
  AccountTemplate(AccountType.assets, "支付宝"),
  AccountTemplate(AccountType.assets, "微信钱包"),
  AccountTemplate(AccountType.assets, "储值卡", desc: "饭卡、公交卡"),
  AccountTemplate(AccountType.assets, "借出", desc: "别人欠我的钱"),
];
const List<AccountTemplate> LIABILITIES_ACCOUNT_TEMPLATES = <AccountTemplate>[
  AccountTemplate(AccountType.liabilities, "信用卡"),
  AccountTemplate(AccountType.liabilities, "蚂蚁花呗"),
  AccountTemplate(AccountType.liabilities, "京东白条"),
  AccountTemplate(AccountType.liabilities, "借出", desc: "我欠别人的钱"),
];