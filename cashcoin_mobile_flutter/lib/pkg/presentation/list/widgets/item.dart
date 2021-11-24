import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String type;
  final String ref;
  final double amount;
  final String createdAt;
  final String concept;
  final String city;
  final String estate;

  const Item(
      {Key? key,
      required this.type,
      required this.ref,
      required this.amount,
      required this.createdAt,
      required this.concept, required this.city, required this.estate,})
      : super(key: key);

  Icon? _returnIcon() {
    if(type == 'WITHDRAW') {
      return const Icon(Icons.send_to_mobile, color: DarkPalette.redWarning,);
    }
    return const Icon(Icons.system_security_update, color: DarkPalette.greenConfirm,);
  }
/*
  transactions.dot,
  locations.city,
  locations.estate*/
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _returnIcon(),
      title: Text(ref, style: const TextStyle(color: DarkPalette.darkGreen, fontWeight: FontWeight.bold)),
      subtitle: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('amount: $amount, concept: $concept', style: const TextStyle(color: Colors.white70)),
            Text('location: $city, $estate', style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
