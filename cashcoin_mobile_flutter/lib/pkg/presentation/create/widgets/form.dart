import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/create/widgets/sections/account_section.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/create/widgets/sections/address_section.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/create/widgets/sections/personal_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Column(
      children: [
        const ListTile(
            title: Text(
              'personal information',
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )),
        const PersonalSection(),
        SizedBox(
          height: 2 * space,
        ),
        const AccountSection(),
        SizedBox(
          height: 2 * space,
        ),
        const AddressSection(),
      ],
    );
  }
}
