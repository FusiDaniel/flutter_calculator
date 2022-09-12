import 'package:flutter/material.dart';
import 'package:flutter_calculator/components/button.dart';
import 'package:flutter_calculator/components/button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) cb;

  const Keyboard({super.key, required this.cb});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          ButtonRow(
            buttons: [
              Button.special(text: 'C/AC', cb: cb, primaryFunction: 'C', secondaryFunction: 'AC',),
              Button.special(text: '( )', cb: cb),
              Button.special(text: '%', cb: cb),
              Button.function(text: '÷', cb: cb),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '7', cb: cb),
              Button(text: '8', cb: cb),
              Button(text: '9', cb: cb),
              Button.function(text: 'x', cb: cb),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '4', cb: cb),
              Button(text: '5', cb: cb),
              Button(text: '6', cb: cb),
              Button.function(text: '-', cb: cb),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '1', cb: cb),
              Button(text: '2', cb: cb),
              Button(text: '3', cb: cb),
              Button.function(text: '+', cb: cb),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '0', cb: cb),
              Button(text: '00', cb: cb),
              Button(text: '.', cb: cb),
              Button.function(text: '=', cb: cb),
            ],
          ),
        ],
      ),
    );
  }
}
