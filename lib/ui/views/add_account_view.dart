
import 'package:flutter/material.dart';
import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/viewmodel/account_model.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';
import 'package:momentum_test/ui/widgets/add_account_content.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class AddAccountView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AddAccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalUser user = Provider.of<LocalUser>(context, listen: false);
    return BaseView<AccountModel>(onModelReady: (model) {
    }, builder: (BuildContext context, AccountModel model, Widget child) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: widgetBgColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: widgetBgColor),
          title: Text("Add Account",
              style: appBarTitleStyle),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              child: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : AddAccountContent(errorMessage: model.errorMessage,
              nameController: model.nameController, accountNumberController: model.accountNumberController,
              balanceController: model.balanceController, overdraftController: model.overdraftController,
              onClickAddAccount: () {
                    model.addAccount(user, () {
                      UIHelper.showDialogOneAction(
                        _scaffoldKey.currentContext,
                        Text("Add Account"),
                        Text("Your account has been saved successfully!"),
                            () {
                          model.errorMessage = null;
                          Navigator.of(_scaffoldKey.currentContext).pop();
                        },
                        "OK",
                      );
                    });
              },)
          ),
        ),
      );
    });
  }
}
