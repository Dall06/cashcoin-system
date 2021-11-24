import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends ConsumerWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Logo(
          color: DarkPalette.blackBg,
          path: "cashcoin",
          size: 90,
        ),
        Text(
          'cash-coin',
          style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}
