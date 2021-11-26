import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/select.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/providers/select.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/dashboard/widgets/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;
    final accountBind = ref.watch(aBindingProvider);
    final statsBind = ref.watch(sBindingProvider);
    print(statsBind);

    return Scaffold(
      appBar: AppBar(
        title: Text('welcome back ' + accountBind.name + '!',
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: DarkPalette.darkGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white70),
            onPressed: () async {
              await ref.read(sessionProvider.notifier).refresh();
              await ref.read(txnsProvider.notifier).refresh();
            },
          ),
        ],
      ),
      backgroundColor: DarkPalette.blackBg,
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
              title: Text('account resume',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Card(
              color: DarkPalette.darkGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    ListTile(
                        title: Text('last access date: ${accountBind.lad}',
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 14))),
                    ListTile(
                      trailing: IconButton(
                        icon: const Icon(Icons.account_box,
                            color: Colors.white70),
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/account'),
                      ),
                      title: const Text(
                        'account',
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: space,
            ),
            Card(
              color: DarkPalette.lightBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  title: Text('current balance: ${accountBind.balance}',
                      style: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            StatusCard(
              status: statsBind.status,
              savings: statsBind.savings.toString(),
              porcentage: statsBind.porcentage.toString(),
              balance: accountBind.balance.toString(),
              date: accountBind.lad,
            ),
            SizedBox(
              height: space,
            ),
            ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.list, color: Colors.white70),
                onPressed: () => Navigator.of(context).pushNamed('/txns'),
              ),
              title: const Text(
                'check your movements',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
            ),
            SizedBox(
              height: space,
            ),
            const ListTile(
              title: Text('actions',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: Card(
                color: DarkPalette.lightBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.fromSwatch()
                          .copyWith(secondary: DarkPalette.darkGreen),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.send_to_mobile,
                                    color: DarkPalette.darkGreen,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/withdraw');
                                  },
                                ),
                                title: const Text('withdraw',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ))),
                            ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.account_balance_wallet,
                                    color: DarkPalette.darkGreen,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/deposit');
                                  },
                                ),
                                title: const Text('deposit',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ))),
                            ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.system_security_update_warning_rounded,
                                    color: DarkPalette.darkGreen,
                                  ),
                                  onPressed: () {},
                                ),
                                title: const Text('loans',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 16))),
                            ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.account_balance,
                                    color: DarkPalette.darkGreen,
                                  ),
                                  onPressed: () {},
                                ),
                                title: const Text('budgets',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ))),
                          ],
                        ),
                      ),
                    ),
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
