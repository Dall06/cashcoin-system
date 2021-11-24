class Transaction {
  String? uuid;
  TLocation? location;
  String? type;
  String? reference;
  double? amount;
  double? fee;
  bool? done;
  String? concept;
  DateTime? createdAt;

  Transaction(
      {this.uuid,
      this.location,
      this.type,
      this.reference,
      this.amount,
      this.fee,
      this.done,
      this.concept,
      this.createdAt});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      uuid: map['txnuuid'],
      type: map['type'],
      reference: map['ref'],
      amount: map['amount'].toDouble(),
      done: map['done'],
      concept: map['concept'],
      createdAt: map['createdAt'],
      location: TLocation.fromMap(map['location']),
    );
  }
}

class TLocation {
  String? uuid;
  String? country;
  String? city;
  String? estate;
  double? latitude;
  double? longitude;

  TLocation(
      {this.uuid,
      this.country,
      this.city,
      this.estate,
      this.latitude,
      this.longitude});

  factory TLocation.fromMap(Map<String, dynamic> map) {
    return TLocation(
      uuid: map['luuid'],
      country: map['country'],
      city: map['city'],
      estate: map['estate'],
      latitude: map['lat'].toDouble(),
      longitude: map['lon'].toDouble(),
    );
  }
}
