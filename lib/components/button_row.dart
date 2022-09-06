import 'package:flutter/material.dart';
import 'package:flutter_calculator/components/button.dart';

class ButtonRow extends StatelessWidget {
  final List<String> buttonsText;
  final List<int>? flexSizes;
  final List<String> type;
  final void Function(String) cb;

  const ButtonRow(
      {super.key,
      required this.buttonsText,
      this.flexSizes,
      required this.type,
      required this.cb});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
            buttonsText.length,
            (index) => Button(
                  text: buttonsText[index],
                  flexSize: flexSizes?[index],
                  color: _pickColor(type[index]),
                  cb: cb,
                )),
      ),
    );
  }
}

Color _pickColor(String type) {
  const colorDark = Color.fromARGB(255, 82, 82, 82);
  const colorDefault = Color.fromARGB(255, 112, 112, 112);
  const colorOperation = Color.fromARGB(255, 250, 158, 13);

  if (type == 'o') {
    return colorOperation;
  } else if (type == 'd') {
    return colorDark;
  } else {
    return colorDefault;
  }
}
