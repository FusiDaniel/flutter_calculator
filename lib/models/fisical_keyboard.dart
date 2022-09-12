import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/models/memory.dart';

class FisicalKeyboardListener extends RawKeyboardListener {
  final Memory memory;
  final FocusNode focusNode;
  final Widget child;
  final bool? xautofocus;
  late void Function(RawKeyEvent)? onKey;
  final void Function(String) cb;

  static final List<String> allowedKeys =
      List.generate(10, (index) => index.toString()) +
          ['Add', 'Subtract', 'Multiply', 'Divide', 'Decimal', 'Enter'];

  FisicalKeyboardListener({
    super.key,
    super.onKey,
    this.xautofocus,
    required this.cb,
    required this.memory,
    required this.focusNode,
    required this.child,
  }) : super(focusNode: focusNode, child: child, autofocus: xautofocus ?? false) {
    onKey = (event) {
      String pressed = event.logicalKey.keyLabel.replaceAll('Numpad ', '');
      if (event is RawKeyUpEvent) {
        if (pressed == 'Enter') {
          cb('=');
        } else if (pressed == 'Delete') {
          cb('AC');
        } else if (pressed == 'Backspace') {
          cb('C');
        } else if (allowedKeys.contains(pressed)) {
          cb(pressed
              .replaceAll('Add', '+')
              .replaceAll('Subtract', '-')
              .replaceAll('Multiply', 'x')
              .replaceAll('Divide', '÷')
              .replaceAll('Decimal', '.'));
        } else {
          print('invalid key: ${event.logicalKey.keyLabel}');
        }
      }
    };
  }
}
