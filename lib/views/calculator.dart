import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/components/display.dart';
import 'package:flutter_calculator/components/keyboard.dart';
import 'package:flutter_calculator/models/memory.dart';

import '../models/fisical_keyboard.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final FocusNode focusNode = FocusNode();
  final Memory memory = Memory();
  void onPressed(String command) {
    setState(() {
      focusNode.requestFocus();
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FisicalKeyboardListener(
          cb: onPressed,
          memory: memory,
          xautofocus: true,
          focusNode: FocusNode(),
          child: Scaffold(
            backgroundColor: Colors.grey,
            body: Column(
              children: [
                Display(
                  focusNode: focusNode,
                  controller: memory.controller,
                ),
                Keyboard(
                  cb: onPressed,
                )
              ],
            ),
          ),
        ));
  }
}
