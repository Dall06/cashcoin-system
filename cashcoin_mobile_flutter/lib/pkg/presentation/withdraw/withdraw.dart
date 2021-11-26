import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/select.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/providers/make.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/btext.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/button.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithdrawScreen extends ConsumerWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

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

    final abind = ref.watch(aBindingProvider);
    ref.listen<AsyncValue<bool>>(makeTxnProvider, (previous, next) {
      next.when(data: (data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (data == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_buildSnack(context, 'withdrawed', 1));
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
        title: const Text('withdraw',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                  tileColor: DarkPalette.lightBlack,
                  title: Text(
                    'current balance: ${abind.balance}',
                    style: const TextStyle(
                      color: DarkPalette.darkGreen,
                      fontSize: 18,
                    ),
                  )),
            ),
            SizedBox(
              height: space,
            ),
            const ListTile(
                title: Text(
              'make a transfer',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 2 * space,
            ),
            Expanded(
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(secondary: DarkPalette.darkGreen),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CFormField(
                        label: "to",
                        prefIcn: Icons.account_box,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(makeTxnProvider.notifier)
                            .setValue('to', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: "amount",
                        prefIcn: Icons.money,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(makeTxnProvider.notifier)
                            .setValue('amount', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'concept',
                        prefIcn: Icons.description,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(makeTxnProvider.notifier)
                            .setValue('concept', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'reference',
                        prefIcn: Icons.looks_6,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(makeTxnProvider.notifier)
                            .setValue('ref', value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2 * space,
            ),
            Button(
              title: const ButtonText(title: 'confirm', error: null),
              onPress: () {
                ref.read(makeTxnProvider.notifier).submit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
