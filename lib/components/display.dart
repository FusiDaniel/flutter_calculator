import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Display extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  const Display({super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Container(
            color: const Color.fromARGB(255, 48, 48, 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
                    child: Column(
                      children: [
                        AutoSizeTextField(
                          focusNode: focusNode,
                          readOnly: true,
                          showCursor: true,
                          cursorColor: Colors.white,
                          controller: controller,
                          minFontSize: 50,
                          minLines: 1,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.end,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w200,
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 100),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}