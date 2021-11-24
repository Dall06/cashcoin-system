import 'package:cashcoin_mobile_flutter/config/layout.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/auth/providers/auth.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Column(
      children: [
        CFormField(
            label: "email",
            prefIcn: Icons.email,
            type: 1,
            obscured: false,
            ftype: 1,
            onChange: (value) {
              ref.read(authProvider.notifier).setUser(value);
            }),
        SizedBox(
          height: space,
        ),
        CFormField(
          label: 'password',
          prefIcn: Icons.lock,
          type: 2,
          obscured: true,
          ftype: 1,
          onChange: (value) {
            ref.read(authProvider.notifier).setPassword(value);
          },
        ),
      ],
    );
  }
}
