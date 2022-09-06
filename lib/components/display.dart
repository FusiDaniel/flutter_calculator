import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Display extends StatelessWidget {
  final String text;

  const Display({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Container(
            color: const Color.fromARGB(255, 48, 48, 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    text,
                    minFontSize: 20,
                    maxFontSize: 80,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
