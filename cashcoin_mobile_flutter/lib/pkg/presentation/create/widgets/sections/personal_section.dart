import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/create.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalSection extends ConsumerStatefulWidget {
  const PersonalSection({Key? key}) : super(key: key);

  @override
  _PersonalSectionState createState() => _PersonalSectionState();
}

class _PersonalSectionState extends ConsumerState<PersonalSection> {
  bool _customTileExpanded = false;

/*  late TextEditingController _controllerl;
  @override
  void initState() {
    super.initState();
    _controllerl = TextEditingController();
  }*/

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
          'address',
          style: TextStyle(
              color: Colors.white60, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          _customTileExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: Colors.white60,
        ),
        children: <Widget>[
          CFormField(
            label: 'name',
            prefIcn: Icons.person,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) =>
                ref.read(createProvider.notifier).setValue("name", value),
          ),
          SizedBox(
            height: space,
          ),
          CFormField(
            label: 'last name',
            prefIcn: Icons.person,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) =>
                ref.read(createProvider.notifier).setValue("lname", value),
          ),
          SizedBox(
            height: space,
          ),
          CFormField(
            label: 'occupation',
            prefIcn: Icons.star_rounded,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) =>
                ref.read(createProvider.notifier).setValue("occupation", value),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
