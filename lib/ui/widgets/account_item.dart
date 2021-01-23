import 'package:flutter/material.dart';
import 'package:momentum_test/core/model/account.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';

class AccountItem extends StatelessWidget {
  final Account account;
  final Function(Account) onTap;

  const AccountItem(
      {Key key, this.account, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        color: primaryColorLighter,
        padding: EdgeInsets.symmetric(vertical: 4),
        margin: EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
          dense: true,
          title: Text(
            '${account.name} ',
            style: textStyleBold,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance: ${account.balance?? ""}',
                style: subTextStyle,
              ),
              Text(
                'Account Number: ${account.accountNumber}',
                style: textStyleSmall,
              ),
            ],
          ),
          onTap: () {
            onTap(account);
          },
        ),
      ),
    );
  }
}
