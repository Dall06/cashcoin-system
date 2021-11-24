import 'package:cashcoin_mobile_flutter/pkg/presentation/create/create.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/dashboard/dashboard.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/deposit/deposit.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/login/login.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/sett/settings.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/sett/widgets/forms/account.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/sett/widgets/forms/address.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/sett/widgets/forms/pass.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/sett/widgets/forms/personal.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/list/list.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/withdraw/withdraw.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  static Map<String, WidgetBuilder> generateRoutes() {
    return <String, WidgetBuilder>{
      '/':  (context) => const LoginScreen(),
      '/create': (context) => const CreateScreen(),
      '/dashboard': (context) => const DashboardScreen(),
      '/txns': (context) => const TTListScreen(),
      '/deposit': (context) => const DepositScreen(),
      '/account': (context) => const AccountScreen(),
      '/mod_account': (context) => const FormModAccount(),
      '/mod_address': (context) => const FormModAddress(),
      '/mod_personal': (context) => const FormModPersonal(),
      '/mod_pass': (context) => const FormModPassword(),
      '/withdraw': (context) => const WithdrawScreen(),
      /*
      '/mod_account': (context) => const AccountScreen(),
      '/mod_account': (context) => const AccountScreen(),
      '/mod_account': (context) => const AccountScreen(),*/
    };
  }
}