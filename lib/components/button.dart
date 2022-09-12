import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  late Color? color;
  final String text;
  final String? primaryFunction;
  final String? secondaryFunction;
  final int? flexSize;
  final void Function(String) cb;

  Button(
      {super.key,
      required this.text,
      this.flexSize,
      required this.cb,
      this.primaryFunction, this.secondaryFunction}) {
        color = Color.fromARGB(255, 112, 112, 112);
      }
  
  Button.function(
      {super.key,
      required this.text,
      this.flexSize,
      this.color,
      required this.cb,
      this.primaryFunction, this.secondaryFunction}) {
        color = Color.fromARGB(255, 250, 158, 13);
      }
  
  Button.special(
      {super.key,
      required this.text,
      this.flexSize,
      this.color,
      required this.cb,
      this.primaryFunction, this.secondaryFunction}) {
        color = Color.fromARGB(255, 82, 82, 82);
      }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flexSize ?? 1,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
              onPressed: () {
                cb(primaryFunction ?? text);
              },
              onLongPress: () {
                cb(secondaryFunction ?? '');
              },
              child: Text(
                text,
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300),
              )),
        ));
  }
}
