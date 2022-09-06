import 'package:flutter/material.dart';
import 'package:flutter_calculator/components/button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) cb;

  const Keyboard({super.key, required this.cb});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          ButtonRow(
            buttonsText: const ['AC', '%', '÷'],
            flexSizes: const [2, 1, 1],
            type: const ['d', 'd', 'o'],
            cb: cb,
          ),
          ButtonRow(
            buttonsText: const ['7', '8', '9', 'x'],
            type: const ['', '', '', 'o'],
            cb: cb,
          ),
          ButtonRow(
            buttonsText: const ['4', '5', '6', '-'],
            type: const ['', '', '', 'o'],
            cb: cb,
          ),
          ButtonRow(
            buttonsText: const ['1', '2', '3', '+'],
            type: const ['', '', '', 'o'],
            cb: cb,
          ),
          ButtonRow(
            buttonsText: const ['0', '00', ',', '='],
            type: const ['', '', '', 'o'],
            cb: cb,
          ),
        ],
      ),
    );
  }
}
