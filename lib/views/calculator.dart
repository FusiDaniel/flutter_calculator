import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/components/display.dart';
import 'package:flutter_calculator/components/keyboard.dart';
import 'package:flutter_calculator/models/memory.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();
  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    List<String> allowedKeys = List.generate(10, (index) => index.toString()) +
        ['Add', 'Subtract', 'Multiply', 'Divide', 'Decimal', 'Enter'];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: (event) {
            String pressed =
                event.logicalKey.keyLabel.replaceAll('Numpad ', '');
            if (event is RawKeyUpEvent) {
              if (pressed == 'Enter') {
                _onPressed('=');
              } else if (pressed == 'Backspace') {
                _onPressed('AC');
              } else if (allowedKeys.contains(pressed)) {
                _onPressed(pressed);
              } else {
                print(event.logicalKey.keyLabel);
              }
            }
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Display(
                  controller: memory.controller,
                ),
                Keyboard(
                  cb: _onPressed,
                )
              ],
            ),
          ),
        ));
  }
}
