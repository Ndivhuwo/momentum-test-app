import 'package:flutter/material.dart';
import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/viewmodel/account_model.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';
import 'package:momentum_test/ui/widgets/account_details.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class AccountView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String accountId;

  AccountView({Key key, this.accountId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalUser user = Provider.of<LocalUser>(context, listen: false);
    return BaseView<AccountModel>(onModelReady: (model) {
      model.getAccountInfo(user, accountId);
    }, builder: (BuildContext context, AccountModel model, Widget child) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: widgetBgColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: widgetBgColor),
          title: Text("Account Details", style: appBarTitleStyle),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  :  AccountDetails(
                          errorMessage: model.errorMessage,
                          account: model.account,
                          depositAmountController:
                              model.depositAmountController,
                          withdrawalAmountController:
                              model.withdrawalAmountController,
                          onClickMakeDeposit: () {
                            model.depositAmount(user, accountId, () {
                              UIHelper.showDialogOneAction(
                                _scaffoldKey.currentContext,
                                Text("Make Deposit"),
                                Text(
                                    "Your deposit has been made successfully!"),
                                () {
                                  model.getAccountInfo(user, accountId);
                                },
                                "OK",
                              );
                            });
                          },
                          onClickMakeWithdrawal: () {
                            model.withdrawAmount(user, accountId, () {
                              UIHelper.showDialogOneAction(
                                _scaffoldKey.currentContext,
                                Text("Make Withdrawal"),
                                Text(
                                    "Your withdrawal has been made successfully!"),
                                () {
                                  model.getAccountInfo(user, accountId);
                                },
                                "OK",
                              );
                            });
                          },
                        )),
        ),
      );
    });
  }
}
