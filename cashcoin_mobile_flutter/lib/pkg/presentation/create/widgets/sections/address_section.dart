import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/create.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressSection extends ConsumerStatefulWidget {
  const AddressSection({Key? key}) : super(key: key);

  @override
  _AddressSectionState createState() => _AddressSectionState();
}

class _AddressSectionState extends ConsumerState<AddressSection> {
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
            label: 'country',
            prefIcn: Icons.map,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) => ref.read(createProvider.notifier).setValue("country", value),
          ),
          SizedBox(
            height: space,
          ),
          CFormField(
            label: 'city',
            prefIcn: Icons.location_city,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) => ref.read(createProvider.notifier).setValue("city", value),
          ),
          SizedBox(
            height: space,
          ),
          CFormField(
            label: 'estate',
            prefIcn: Icons.location_on ,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) => ref.read(createProvider.notifier).setValue("estate", value),
          ),
          SizedBox(
            height: space,
          ),
          CFormField(
            label: 'postal code',
            prefIcn: Icons.location_on ,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) => ref.read(createProvider.notifier).setValue("pc", value),
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
            onChange: (value) => ref.read(createProvider.notifier).setValue("street", value),
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
            onChange: (value) => ref.read(createProvider.notifier).setValue("bnum", value),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
