import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/address.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/btext.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/button.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormModAddress extends ConsumerWidget {
  const FormModAddress({Key? key}) : super(key: key);

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
    ref.listen<AsyncValue<bool>>(modifyAddressProvider, (previous, next) {
      next.when(data: (data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if(data == true) {
          ScaffoldMessenger.of(context).showSnackBar(_buildSnack(context, 'modified', 1));
          Navigator.of(context).pop();
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
        title: const Text('modify address',
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
            const ListTile(
                title: Text(
              'where do you live now?',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 2 * space),
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
                        label: 'city',
                        prefIcn: Icons.location_city,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(modifyAddressProvider.notifier)
                            .setValue('city', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'estate',
                        prefIcn: Icons.location_on,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(modifyAddressProvider.notifier)
                            .setValue('estate', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'street',
                        prefIcn: Icons.streetview,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(modifyAddressProvider.notifier)
                            .setValue('street', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'country',
                        prefIcn: Icons.map,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(modifyAddressProvider.notifier)
                            .setValue('country', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'number',
                        prefIcn: Icons.format_list_numbered,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(modifyAddressProvider.notifier)
                            .setValue('bnum', value),
                      ),
                      SizedBox(
                        height: space,
                      ),
                      CFormField(
                        label: 'postal code',
                        prefIcn: Icons.location_on,
                        type: 1,
                        obscured: false,
                        ftype: 1,
                        onChange: (value) => ref
                            .read(modifyAddressProvider.notifier)
                            .setValue('pc', value),
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
              title: const ButtonText(title: 'modify', error: null),
              onPress: () {
                ref.read(modifyAddressProvider.notifier).submit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
