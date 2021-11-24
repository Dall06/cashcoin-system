import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/create.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSection extends ConsumerStatefulWidget {
  const AccountSection({Key? key}) : super(key: key);

  @override
  _AccountSectionState createState() => _AccountSectionState();
}

class _AccountSectionState extends ConsumerState<AccountSection> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        maintainState: true,
        childrenPadding: EdgeInsets.only(
            left: DesignPaddings.paddingM, right: DesignPaddings.paddingM, top: space, bottom: space),
        backgroundColor: DarkPalette.lightBlack,
        collapsedBackgroundColor: DarkPalette.lightBlack,
        title: const Text(
          'account',
          style: TextStyle(
              color: Colors.white60, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          _customTileExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: Colors.white60,
        ),
        children: <Widget>[
          CFormField(
              label: "email",
              prefIcn: Icons.email,
              type: 1,
              obscured: false,
              ftype: 1,
              onChange: (value) =>
                  ref.read(createProvider.notifier).setValue("email", value)),
          SizedBox(
            height: space,
          ),
          CFormField(
              label: "phone",
              prefIcn: Icons.phone,
              type: 1,
              obscured: false,
              ftype: 1,
              onChange: (value) =>
                  ref.read(createProvider.notifier).setValue("phone", value)),
          SizedBox(
            height: space,
          ),
          CFormField(
            label: 'password',
            prefIcn: Icons.lock,
            type: 2,
            obscured: true,
            ftype: 1,
            onChange: (value) =>
                ref.read(createProvider.notifier).setValue("password", value),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
