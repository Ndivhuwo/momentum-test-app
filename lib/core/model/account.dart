class Account {
  String id;
  String userId;
  String name;
  String accountNumber;
  double balance;
  double overdraft;

  Account({this.id, this.userId, this.name, this.accountNumber, this.balance, this.overdraft});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    accountNumber = json['accountNumber'];
    balance = double.parse(json['balance'].toString());
    overdraft = double.parse(json['overdraft'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.id != null) {
      data['id'] = this.id;
    }
    if(this.userId != null) {
      data['userId'] = this.userId;
    }
    data['name'] = this.name;
    data['accountNumber'] = this.accountNumber;
    data['balance'] = this.balance;
    data['overdraft'] = this.overdraft;
    return data;
  }
}