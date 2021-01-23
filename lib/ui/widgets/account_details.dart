import 'package:flutter/material.dart';
import 'package:momentum_test/core/model/account.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';
import 'package:momentum_test/ui/widgets/plain_text_field.dart';

class AccountDetails extends StatelessWidget {
  final Account account;
  final TextEditingController depositAmountController;
  final TextEditingController withdrawalAmountController;
  final Function onClickMakeDeposit;
  final Function onClickMakeWithdrawal;
  final String errorMessage;


  AccountDetails(
      {this.account,
      this.depositAmountController,
      this.withdrawalAmountController,
      this.onClickMakeDeposit,
      this.onClickMakeWithdrawal, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        account != null ? Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              shadowColor: primaryColor,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
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
                        'Balance: ${account.balance ?? ""}',
                        style: subTextStyle,
                      ),
                      Text(
                        'Account Number: ${account.accountNumber}',
                        style: textStyleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  dense: true,
                  title: PlainTextField(
                    controller: depositAmountController,
                    boarder: true,
                    hint: "Deposit Amount",
                    horizontalPadding: 0,
                    horizontalContentPadding: 16,
                    customHint: false,
                    borderRadiusPresent: true,
                    width: 200,
                    color: widgetBgColor,
                  ),
                  trailing: SizedBox(
                    width: 150,
                    height: 40,
                    child: Container(
                      child: RaisedButton(
                        color: secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Deposit',
                          style: titleStyleWhite,
                        ),
                        onPressed: onClickMakeDeposit,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  dense: true,
                  title: PlainTextField(
                    controller: withdrawalAmountController,
                    boarder: true,
                    hint: "Withdraw Amount",
                    horizontalPadding: 0,
                    horizontalContentPadding: 16,
                    customHint: false,
                    borderRadiusPresent: true,
                    width: 200,
                    color: widgetBgColor,
                  ),
                  trailing: SizedBox(
                    width: 150,
                    height: 40,
                    child: Container(
                      child: RaisedButton(
                        color: secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Withdraw',
                          style: titleStyleWhite,
                        ),
                        onPressed: onClickMakeWithdrawal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) : Container(),

        UIHelper.verticalSpaceMedium(),
        errorMessage != null
            ? Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : Container(),
        UIHelper.verticalSpaceMedium(),
      ],
    );
  }
}
