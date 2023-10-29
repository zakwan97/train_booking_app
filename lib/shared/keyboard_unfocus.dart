import 'package:flutter/material.dart';

class KeyboardUnfocusFunction extends StatelessWidget {
  final Widget child;
  const KeyboardUnfocusFunction({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
