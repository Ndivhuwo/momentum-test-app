import 'dart:convert';

import 'package:momentum_test/core/model/account.dart';
import 'package:momentum_test/core/model/client_details.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/model/login_request.dart';

import 'package:http/http.dart' as http;
import 'package:momentum_test/core/shared/core_helper.dart';

class MomentumApi {
  static String authEndpoint = 'www.googleapis.com';
  static String backendEndpoint = 'us-central1-momentumtest-bfdef.cloudfunctions.net';
  var client = new http.Client();

  Future<LocalUser> login(LoginRequest loginRequest) async{
    Map<String, String> queryParameters = {
      'key': "${CoreHelper.googleAPIKey}",
    };
    Uri uri = Uri.https(authEndpoint, "/identitytoolkit/v3/relyingparty/verifyPassword", queryParameters);
    final response = await client.post(uri, body: json.encode(loginRequest.toJson()),);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return LocalUser.fromJson(json.decode(response.body));
    }else if(response.body != null) {
      return Future.error(response.body);
    } else {
      return Future.error('${response.toString()}');
    }
  }

  Future<List<Account>> getClientDetails(
      {String localId, String idToken}) async{
    Map<String, String> queryParameters = {
      'auth': idToken,
      'userId': localId,
    };
    Map<String, String> headers = {
      'Content-Type': 'Application/JSON'
    };
    Uri uri = Uri.https(backendEndpoint, "/app/api/v1/account/findByUserId", queryParameters);
    final response = await client.get(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      print("Accounts: ${response.body}");
      return (json.decode(response.body) as List)
          .map((data) => Account.fromJson(data))
          .toList();
    }else if(response.body != null) {
      return Future.error(response.body);
    } else {
      return Future.error('${response.toString()}');
    }
  }

  Future<Account> addAccount(String idToken, String localId, Account account) async{
    Map<String, String> queryParameters = {
      'auth': idToken,
      'userId': localId,
    };
    Map<String, String> headers = {
    'Content-Type': 'Application/JSON'
    };

    print("UserId: $localId");
    print("Account: ${json.encode(account.toJson())}");
    Uri uri = Uri.https(backendEndpoint, "/app/api/v1/account/create", queryParameters);
    final response = await client.put(uri, headers: headers, body: json.encode(account.toJson()));
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return Account.fromJson(json.decode(response.body));
    }else if(response.body != null) {
      return Future.error(response.body);
    } else {
      return Future.error('${response.toString()}');
    }
  }

  Future<Account> getAccountInfo(String idToken, String accountId) async{
    Map<String, String> headers = {
    'Content-Type': 'Application/JSON'
    };
    Map<String, String> queryParameters = {
      'auth': idToken,
    };
    print("Account: $accountId");
    Uri uri = Uri.https(backendEndpoint, "/app/api/v1/account/$accountId", queryParameters);
    final response = await client.get(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return Account.fromJson(json.decode(response.body));
    }else if(response.body != null) {
      return Future.error(response.body);
    } else {
      return Future.error('${response.toString()}');
    }
  }

  Future<void> depositAmount(String idToken, String accountId, double amount) async{
    Map<String, String> headers = {
    'Content-Type': 'Application/JSON'
    };
    Map<String, String> queryParameters = {
      'auth': idToken,
      'amount': "$amount",
    };
    print("amount: $amount");
    Uri uri = Uri.https(backendEndpoint, "/app/api/v1/account/deposit/$accountId", queryParameters);
    final response = await client.post(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return;
    }else if(response.body != null) {
      return Future.error(response.body);
    } else {
      return Future.error('${response.toString()}');
    }
  }

  Future<void> withdrawAmount(String idToken, String accountId, double amount) async{
    Map<String, String> headers = {
    'Content-Type': 'Application/JSON'
    };
    Map<String, String> queryParameters = {
      'auth': idToken,
      'amount': "$amount",
    };
    print("UserId: $accountId");
    Uri uri = Uri.https(backendEndpoint, "/app/api/v1/account/withdraw/$accountId", queryParameters);
    final response = await client.post(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return;
    }else if(response.body != null) {
      return Future.error(response.body);
    } else {
      return Future.error('${response.toString()}');
    }
  }
}