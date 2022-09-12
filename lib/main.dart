import 'package:flutter/material.dart';
import 'package:flutter_calculator/views/calculator.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('ReCalc');
    const Size size = Size(490, 752);
    setWindowMinSize(size);
    setWindowMaxSize(size);
  }
  runApp(const Calculator());
}
