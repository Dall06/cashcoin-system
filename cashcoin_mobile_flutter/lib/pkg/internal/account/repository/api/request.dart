class ReqCreate {
  String email;
  String? phone;
  String password;
  String city;
  String estate;
  String street;
  int buildingNumber;
  String country;
  String postalCode;
  String name;
  String lastName;
  String occupation;

  ReqCreate({
    required this.email,
    this.phone,
    required this.password,
    required this.city,
    required this.estate,
    required this.street,
    required this.buildingNumber,
    required this.country,
    required this.postalCode,
    required this.name,
    required this.lastName,
    required this.occupation,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'city': city,
      'estate': estate,
      'street': street,
      'bnum': buildingNumber,
      'country': country,
      'pc': postalCode,
      'name': name,
      'lname': lastName,
      'occupation': occupation
    };
  }
}

class ReqStatus {
  String uuid;
  String status;

  ReqStatus({required this.uuid, required this.status});

  Map<String, dynamic> toJson() {
    return {'auuid': uuid, 'status': status};
  }
}

class ReqAccount {
  String email;
  String? phone;
  String password;
  String? newEmail;
  String? newPhone;

  ReqAccount(
      {required this.email,
      this.phone,
      required this.password,
      this.newEmail,
      this.newPhone});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'newEmail': newEmail,
      'newPhone': newPhone,
    };
  }
}

class ReqPassword {
  String email;
  String? phone;
  String password;
  String newPassword;

  ReqPassword(
      {required this.email,
      this.phone,
      required this.password,
      required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'newPassword': newPassword
    };
  }
}

class ReqAddress {
  String uuid;
  String city;
  String estate;
  String street;
  int buildingNumber;
  String country;
  String postalCode;

  ReqAddress(
      {required this.uuid,
      required this.city,
      required this.estate,
      required this.street,
      required this.buildingNumber,
      required this.country,
      required this.postalCode});

  Map<String, dynamic> toJson() {
    return {
      'auuid': uuid,
      'city': city,
      'estate': estate,
      'street': street,
      'bnum': buildingNumber,
      'country': country,
      'pc': postalCode,
    };
  }
}

class ReqPersonal {
  String uuid;
  String name;
  String lastName;
  String occupation;

  ReqPersonal({
    required this.uuid,
    required this.name,
    required this.lastName,
    required this.occupation,
  });

  Map<String, dynamic> toJson() {
    return {
      'auuid': uuid,
      'name': name,
      'lname': lastName,
      'occupation': occupation
    };
  }
}
