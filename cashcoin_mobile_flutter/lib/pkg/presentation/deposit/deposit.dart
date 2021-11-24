import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/select.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/deposit/widgets/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DepositScreen extends ConsumerWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;
    final deposit = ref.read(dBindingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DarkPalette.blackBg,
      appBar: AppBar(
        title: const Text('deposit info', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
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
              title: Text('deposit information',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  )),
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
                      const ListTile(
                        title: Text('code',
                            style: TextStyle(
                              color: Colors.white70,
                            )),
                      ),
                      DataTile(data: deposit.code),
                      SizedBox(height: space,),
                      QrImage(
                        foregroundColor: DarkPalette.darkGreen,
                        data: deposit.code,
                        version: QrVersions.auto,
                        size: 150.0,
                      ),
                      SizedBox(height: space,),
                      const ListTile(
                        title: Text('clabe',
                            style: TextStyle(
                              color: Colors.white70,
                            )),
                      ),
                      DataTile(data: deposit.clabe),
                      SizedBox(height: space,),
                      QrImage(
                        foregroundColor: DarkPalette.darkGreen,
                        data:  deposit.clabe,
                        version: QrVersions.auto,
                        size: 150.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
