import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepositCard extends StatelessWidget {
  final String name;
  final String code;
  final String email;

  DepositCard({@required this.code, @required this.email, @required this.name});

  _copyToClipboard(BuildContext context) {
    Clipboard.setData(new ClipboardData(text: code)).then((_){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("Code address copied to clipboard")));
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = _height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Card(
      elevation: 4,
      color: Palette.darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => _copyToClipboard(context),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Tap me to copy the code!',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2 * space,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: space,
                  ),
                  Text(
                    this.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: space,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: space,
                  ),
                  Text(
                    this.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: space,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: space,
                  ),
                  Text(
                    this.code,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
