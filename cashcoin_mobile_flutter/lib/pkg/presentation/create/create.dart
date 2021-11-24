import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/create.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/create/widgets/form.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/create/widgets/privacy.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/btext.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateScreen extends ConsumerWidget {
  const CreateScreen({Key? key}) : super(key: key);

  SnackBar _buildSnack(BuildContext context, String message, int status) {
    Color color = DarkPalette.lightBlack;

    if (status == 1) {
      color = DarkPalette.darkGreen;
    } else if (status == 2) {
      color = DarkPalette.redWarning;
    }

    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'undo',
        textColor: Colors.white70,
        onPressed: () {},
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

    ref.listen<AsyncValue<bool>>(createProvider, (previous, next) {
      next.when(data: (data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (data == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_buildSnack(context, 'created! now login', 1));
          Navigator.of(context).pop();
        }
      }, error: (error, _) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            _buildSnack(context, 'error: ' + error.toString(), 2));
      }, loading: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(_buildSnack(context, 'loadding ...', 0));
      });
    });
    return Scaffold(
      backgroundColor: DarkPalette.blackBg,
      appBar: AppBar(
        title: const Text('register',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_left, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: DesignPaddings.paddingL,
            right: DesignPaddings.paddingL,
            top: 3 * space,
            bottom: 2 * space),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const PrivacyText(),
            SizedBox(height: 2 * space),
            Expanded(
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(secondary: DarkPalette.darkGreen),
                ),
                child: const SingleChildScrollView(
                  child: RegisterForm(),
                ),
              ),
            ),
            SizedBox(
              height: space,
            ),
            Button(
              title: const ButtonText(title: 'finish', error: null),
              onPress: () => ref.read(createProvider.notifier).submit(),
            ),
          ],
        ),
      ),
    );
  }
}
