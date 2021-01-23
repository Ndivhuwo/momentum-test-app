import 'account.dart';

class ClientDetails {
  List<Account> accounts;
  int age;
  String name;

  ClientDetails({this.accounts, this.age, this.name});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = [];
      json['accounts'].forEach((v) {
        accounts.add(new Account.fromJson(v));
      });
    }
    age = json['age'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accounts != null) {
      data['accounts'] = this.accounts.map((v) => v.toJson()).toList();
    }
    data['age'] = this.age;
    data['name'] = this.name;
    return data;
  }

}