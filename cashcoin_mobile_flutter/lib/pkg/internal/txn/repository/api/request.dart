class ReqMake {
  String auuid;
  String reference;
  String toUUID;
  double amount;
  String concept;
  String country;
  String city;
  String estate;
  double latitude;
  double longitude;

  ReqMake({
    required this.auuid,
    required this.toUUID,
    required this.amount,
    required this.concept,
    required this.reference,
    required this.country,
    required this.city,
    required this.estate,
    required this.latitude,
    required this.longitude,});

  Map<String, dynamic> toJson() {
    return {
      'auuid': auuid,
      'toAUUID': toUUID,
      'amount': amount,
      'concept': concept,
      'reference': reference,
      'country': country,
      'city': city,
      'estate': estate,
      'lat': latitude,
      'lon': longitude,
    };
  }
}
