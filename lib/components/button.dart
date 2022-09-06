import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final Color? color;
  final String text;
  final int? flexSize;
  final void Function(String) cb;
  const Button(
      {super.key,
      required this.text,
      this.flexSize,
      this.color,
      required this.cb});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flexSize ?? 1,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onPressed: () {
                cb(text);
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
