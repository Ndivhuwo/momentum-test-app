import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/core/model/account.dart';
import 'package:momentum_test/core/model/client_details.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/services/momentum_api.dart';
import 'package:momentum_test/core/viewmodel/base_model.dart';

import '../../locator.dart';

class HomeModel extends BaseModel{
  String errorMessage;
  final MomentumApi _momentumApi = locator<MomentumApi>();
  List<Account> accounts = [];

  Future getClientDetails(LocalUser user) async {
    setState(ViewState.Busy);
    errorMessage = null;
    accounts = [];
    _momentumApi.getClientDetails(localId: user.localId, idToken: user.idToken)
    .then((accounts) {
      this.accounts = accounts;
      setState(ViewState.Idle);
    }).catchError((error) {
      errorMessage = '${error.toString()}';
      setState(ViewState.Idle);
    });
  }

}