class UserAccount {
  int id;
  String email;
  String password;
  String phone;

  UserAccount({
    this.id,
    this.email,
    this.password,
    this.phone,
  });

  factory UserAccount.fromJson(Map<String, dynamic> parsedJson) {
    return UserAccount(
        id: parsedJson['accountId'],
        email: parsedJson['email'],
        password: parsedJson['password'],
        phone: parsedJson['phone']);
  }

  Map toJson() {
    return {
      'accountId': id,
      'email': email,
      'password': password,
      'phone': phone
    };
  }
  // isCompleted = json["isCompleted"] == "true",
}

class UserData {
  int id;
  String name;
  String lastName;
  String code;
  num balance;
  UserAccount userAccount;

  UserData(
      {this.id,
      this.name,
      this.lastName,
      this.code,
      this.balance,
      this.userAccount});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return UserData(
        id: parsedJson['id'],
        name: parsedJson['name'],
        lastName: parsedJson['lastName'],
        code: parsedJson['Code'],
        balance: parsedJson['Balance'],
        userAccount: UserAccount.fromJson(parsedJson['account']));
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'Code': code,
      'Balance': balance,
      'account': userAccount
    };
  }
  // isCompleted = json["isCompleted"] == "true",
}

class UserPassUpdate {
  String newPassword;
  UserAccount userAccount;

  UserPassUpdate({this.newPassword, this.userAccount});

  factory UserPassUpdate.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return UserPassUpdate(
        newPassword: parsedJson['newPassword'],
        userAccount: UserAccount.fromJson(parsedJson['currentAccount']));
  }

  Map toJson() {
    return {
      'newPassword': newPassword,
      'currentAccount': userAccount
    };
  }
// isCompleted = json["isCompleted"] == "true",
}
