class AClient {
  String? uuid;
  String? name;
  String? lastName;
  String? occupation;

  AClient({this.uuid, this.name, this.lastName, this.occupation});

  factory AClient.fromMap(Map<String, dynamic> map) {
    return AClient(
      name: map['name'],
      lastName: map['lname'],
    );
  }
}

class Address {
  String? uuid;
  String? country;
  String? city;
  String? estate;
  String? street;
  int? buildingNumber;
  String? postalCode;

  Address(
      {this.uuid,
      this.country,
      this.city,
      this.estate,
      this.street,
      this.buildingNumber,
      this.postalCode});

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      city: map['city'],
      estate: map['estate'],
      country: map['country'],
    );
  }
}

class Account {
  String? uuid;
  AClient? client;
  Address? address;
  String? email;
  String? phone;
  String? password;
  double? balance;
  String? status;
  String? clabe;
  String? lad;

  Account({
    this.uuid,
    this.client,
    this.address,
    this.email,
    this.phone,
    this.password,
    this.balance,
    this.status,
    this.clabe,
    this.lad});

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      uuid: map['auuid'],
      email: map['email'],
      phone:  map['phone'].toString(),
      clabe: map['clabe'],
      balance: map['balance'].toDouble(),
      status: map['status'],
      lad: map['lad'],
      client: AClient.fromMap(map['client']),
      address: Address.fromMap(map['address']),
    );}
}
