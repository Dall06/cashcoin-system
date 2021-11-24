import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/select.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/txn/providers/select.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/list/widgets/filter_tile.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/list/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TTListScreen extends ConsumerWidget {
  const TTListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;
    final filteredList = ref.watch(filteredListProvider);
    final statsBind = ref.read(sBindingProvider);
    final accountBind = ref.read(aBindingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DarkPalette.blackBg,
      appBar: AppBar(
        title: const Text('movements',
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
            Card(
              color: DarkPalette.lightBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    ListTile(
                        title: Text('savings: ${statsBind.savings}',
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold))),
                    ListTile(
                      title: Text('current balance: ${accountBind.balance}',
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: space,
            ),
            const FilterTile(),
            Expanded(
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(secondary: DarkPalette.darkGreen),
                ),
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Item(
                      amount: filteredList[index].amount!,
                      createdAt: filteredList[index].createdAt.toString(),
                      ref: filteredList[index].reference!,
                      type: filteredList[index].type!,
                      concept: filteredList[index].concept!,
                      city: filteredList[index].location!.city!,
                      estate: filteredList[index].location!.estate!,
                    );
                  },
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
                child: Column(
                  children: [
                    ListTile(
                        title: Text('total withdrawed: ${statsBind.withdraws}',
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold))),
                    ListTile(
                      title: Text('total recieved: ${statsBind.deposits}',
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
