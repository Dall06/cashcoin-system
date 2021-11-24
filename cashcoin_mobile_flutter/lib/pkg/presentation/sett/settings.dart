import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/logout.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/sett/widgets/tile.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/btext.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

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

    ref.listen<AsyncValue<bool>>(exitProvider, (previous, next) {
      next.when(data: (data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if(data == true) {
          ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'loggedout', 1));
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }
      }, error: (error, _) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'error: ' + error.toString(), 2));
      }, loading: () {
        ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'loadding ...', 0));
      });
    });

    ref.listen<AsyncValue<bool>>(disableProvider, (previous, next) {
      next.when(data: (data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if(data == true) {
          ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'disabled', 1));
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }
      }, error: (error, _) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'error: ' + error.toString(), 2));
      }, loading: () {
        ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'loadding ...', 0));
      });
    });

    return Scaffold(
      backgroundColor: DarkPalette.blackBg,
      appBar: AppBar(
        title: const Text('account', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_left, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: DarkPalette.darkGreen,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: DesignPaddings.paddingL,
            right: DesignPaddings.paddingL,
            top: 3 * space,
            bottom: 2 * space),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ListTile(
              title: Text('change your info',
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            SizedBox(
              height: 2 * space,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: DarkPalette.lightBlack,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SettingsTile(
                        title: 'address',
                        onTap: () => Navigator.of(context).pushNamed('/mod_address')),
                    SettingsTile(
                        title: 'personal',
                        onTap: () => Navigator.of(context).pushNamed('/mod_personal')),
                    SettingsTile(
                        title: 'account',
                        onTap: () => Navigator.of(context).pushNamed('/mod_account')),
                    SettingsTile(
                        title: 'password',
                        onTap: () => Navigator.of(context).pushNamed('/mod_pass')),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: space,
            ),
            Button(
              title: const ButtonText(title: 'logout', error: null),
              onPress: () {
                ref.read(exitProvider.notifier).submit();
              },
            ),
            Button(
              title: const ButtonText(title: 'disable', error: null),
              onPress: () {
                ref.read(disableProvider.notifier).submit();
              },
            ),
            /*Center(child: Button(title: 'cancel', btype: 'lblack', onPress: () => Navigator.of(context).pop(),)),*/
          ],
        ),
      ),
    );
  }
}
