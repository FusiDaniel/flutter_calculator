import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Memory {
  String _lastExpression = '';
  // String _value = '0';
  TextEditingController _value = TextEditingController(text: '0');

  TextEditingController get controller {
    return _value;
  }

  String get value {
    return _value.text;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      allClear();
    } else if (command == '=') {
      if (isDigit(_value.text)) {
        _value.text = _value.text + _lastExpression;
      }
      updateLastExpression();
      // print(_lastExpression);
      solve();
    } else {
      if (_value.text == '0') {
        if (isDigit(command)) {
          _value.text = command;
        }
      } else {
        _value.text = (_value.text +
            command
                .replaceAll('Add', '+')
                .replaceAll('Subtract', '-')
                .replaceAll('Multiply', 'x')
                .replaceAll('Divide', '÷')
                .replaceAll('Decimal', '.'));
      }
    }
    // updateLastExpression();
  }

  void allClear() {
    _value.text = '0';
    _lastExpression = '';
  }

  void updateLastExpression() {
    int n = _value.text.length - 1;

    while (n > 0 && (isDigit(_value.text[n]) || _value.text[n] == '.')) {
      n--;
    }
    // print('value: $_value.text');
    // print('n: $n');
    RegExp reg = RegExp(r'[0-9]+(\.)?[0-9]*');
    print('s ${reg.stringMatch(_value.text.substring(n))}');
    print('b ${_value.text.substring(n)}');
    if (reg.stringMatch(_value.text.substring(n)) != _value.text.substring(n)) {
      _lastExpression = _value.text.substring(n);
    }
    // print("le: $_lastExpression");
  }

  void solve() {
    if (!isDigit(_value.text[_value.text.length - 1])) {
      _value.text = _value.text.substring(0, _value.text.length - 1);
    }

    Parser p = Parser();
    Expression exp =
        p.parse(_value.text.replaceAll('x', '*').replaceAll('÷', '/'));
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    // print(eval);
    _value.text = removeZeros(eval.toString());
  }

  String removeZeros(String expr) {
    int n = expr.length - 1;
    while (expr[n] != '.') {
      if (expr[n] == '0') {
        n--;
      } else {
        break;
      }
    }
    if (expr[n] == '.') {
      return expr.substring(0, n);
    } else {
      return expr.substring(0, expr.length);
    }
  }

  bool isDigit(String expr) {
    return double.tryParse(expr) != null;
  }
}
