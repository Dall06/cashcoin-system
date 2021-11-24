import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/infrastructure/routes/navigation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashCoin',
      theme: ThemeData(
        splashColor: DarkPalette.darkGreen,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouter.generateRoutes(),
    );
  }
}
