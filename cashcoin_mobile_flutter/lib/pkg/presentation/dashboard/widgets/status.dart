import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final int status;
  final String savings;
  final String porcentage;
  final String balance;
  final String date;

  const StatusCard(
      {Key? key,
      required this.status,
      required this.savings,
      required this.porcentage,
      required this.balance, required this.date})
      : super(key: key);

  String _getEmotion() {
    switch (status) {
      case 0:
        return "mad";
      case 1:
        return "happy";
      case 2:
        return "smile";
      case 3:
        return "love";
      case 4:
        return "cashcoin";
      case 5:
        return "dead";
      default:
        return "happy";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DarkPalette.lightBlack,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Logo(
              color: DarkPalette.blackBg,
              path: _getEmotion(),
              size: 90,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text("your porcentage of savings score is %$porcentage" ,
                      style: const TextStyle(color: Colors.white70,)),
                ),
                ListTile(
                  title: Text('total savings: $savings' ,
                      style: const TextStyle(color: Colors.white70, fontSize: 16)),
                ),
              ],
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
