import 'package:cashcoin_mobile_flutter/config/theme/dark.dart';
import 'package:cashcoin_mobile_flutter/pkg/internal/account/providers/create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyText extends ConsumerStatefulWidget {
  const PrivacyText({Key? key}) : super(key: key);

  @override
  _PrivacyTextState createState() => _PrivacyTextState();
}

class _PrivacyTextState extends ConsumerState<PrivacyText> {
  bool _customTileExpanded = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color _getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white60;
      }
      return DarkPalette.darkGreen;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        backgroundColor: DarkPalette.lightBlack,
        collapsedBackgroundColor: DarkPalette.lightBlack,
        title: RichText(
          text: const TextSpan(
            text: 'read our ',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            children: <TextSpan>[
              TextSpan(
                  text: 'privacy terms',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: DarkPalette.darkGreen)),
            ],
          ),
        ),
        trailing: Icon(
          _customTileExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: Colors.white60,
        ),
        children: <Widget>[
          const Text(
            "Introduction to Very very very long text\nIntroduction to Very very very long text\nIntroduction to Very very very long text\nIntroduction to Very very very long text",
            style: TextStyle(color: Colors.white60),
          ),
          ListTile(
            title: const Text(
              'accept',
              style: TextStyle(color: Colors.white60),
            ),
            leading: Checkbox(
              checkColor: DarkPalette.darkGreen,
              fillColor: MaterialStateProperty.resolveWith(_getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                  ref.read(createProvider.notifier).setTerms(isChecked);
                });
              },
            ),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
