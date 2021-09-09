import 'package:cc_flutter_mobile/data/model/user.dart';

class TransactionType {
  int id;
  String typeDescription;

  TransactionType({this.id, this.typeDescription});

  factory TransactionType.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionType(
        id: parsedJson['id'],
        typeDescription: parsedJson['typeDescription']);
  }

  Map toJson() {
    return {
      'id': id,
      'typeDescription': typeDescription,
    };
  }
}

class TransactionOrder {
  int id;
  num quantity;
  String date;
  TransactionType transactionType;

  TransactionOrder({this.id, this.quantity, this.date, this.transactionType});

  factory TransactionOrder.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return TransactionOrder(
        id: parsedJson['id'],
        quantity: parsedJson['quantity'],
        date: parsedJson['date'],
        transactionType: TransactionType.fromJson(parsedJson['transactionType']));
  }

  Map toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'date': date,
      'transactionType': transactionType,
    };
  }
}

class TransactionDetail {
  int id;
  UserData destination;
  UserData origin;
  String concept;
  TransactionOrder order;

  TransactionDetail({this.id, this.destination, this.origin, this.concept, this.order});


  factory TransactionDetail.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionDetail(
        id: parsedJson['id'],
        destination: UserData.fromJson(parsedJson['destination']),
        origin: UserData.fromJson(parsedJson['origin']),
        concept: parsedJson['concept'],
        order: TransactionOrder.fromJson(parsedJson['transactionOrder']));
  }

  Map toJson() {
    return {
      'id': id,
      'concept': concept,
      'destination': destination,
      'origin': origin,
      'transactionOrder': order,
    };
  }
// isCompleted = json["isCompleted"] == "true",


}

class TransactionUser {
  int id;
  UserData userData;
  TransactionDetail transactionDetail;
  String transactionUserType;
  int transactionUserStatus;

  TransactionUser({
    this.id = 0,
    this.userData,
    this.transactionDetail,
    this.transactionUserType,
    this.transactionUserStatus = 0
  });

  factory TransactionUser.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionUser(
        id: parsedJson['id'],
        userData: UserData.fromJson(parsedJson['userData']),
        transactionDetail: TransactionDetail.fromJson(parsedJson['transactionDetail']),
        transactionUserType: parsedJson['transactionUType'],
        transactionUserStatus: parsedJson['transactionUStatus']);
  }
}
