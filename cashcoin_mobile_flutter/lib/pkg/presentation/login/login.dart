import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/auth/providers/auth.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/login/widgets/form.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/login/widgets/header.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/btext.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  SnackBar _buildSnack(BuildContext context, String message, int status) {
    Color color = DarkPalette.lightBlack;

    if(status == 1) {
      color = DarkPalette.darkGreen;
    } else if(status == 2) {
      color = DarkPalette.redWarning;
    }

    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'undo',
        textColor: Colors.white70,
        onPressed: () { },
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    ref.listen<AsyncValue<bool>>(authProvider, (previous, next) {
      next.when(data: (data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if(data == true) {
          ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'logged', 1));
          Navigator.of(context).pushReplacementNamed('/dashboard');
        }
      }, error: (error, _) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'error: ' + error.toString(), 2));
      }, loading: () {
        ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'loadding ...', 0));
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('authenticate',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: DarkPalette.blackBg,
      body: Padding(
        padding: EdgeInsets.only(
            left: DesignPaddings.paddingL,
            right: DesignPaddings.paddingL,
            top: 3 * space),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(),
            SizedBox(
              height: 2 * space,
            ),
            ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.arrow_right, color: Colors.white70),
                onPressed: () => Navigator.of(context).pushNamed('/create'),
              ),
              title: const Text(
                'tap me to become a member',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 4 * space,
            ),
            const LoginForm(),
            SizedBox(
              height: 2 * space,
            ),
            Button(
              title: const ButtonText(title: 'login', error: null),
              onPress: () {
                ref.read(authProvider.notifier).submit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
