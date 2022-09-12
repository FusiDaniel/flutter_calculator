import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Memory {
  String _lastExpression = '';
  TextEditingController _value = TextEditingController(text: '0');

  TextEditingController get controller {
    return _value;
  }

  String get value {
    return _value.text;
  }

  void applyCommand(String raw_command) {
    String command = raw_command.replaceAll('%', '/100');
    int init =
        min(controller.selection.baseOffset, controller.selection.extentOffset);
    int end =
        max(controller.selection.baseOffset, controller.selection.extentOffset);
    if (command == 'AC') {
      allClear();
    } else if (command == 'C') {
      var cursorPos = controller.selection.base.offset != -1
          ? controller.selection.base.offset
          : _value.text.length;

      if (end - init == _value.text.length) {
        allClear();
      } else if (end > 0) {
        if (end == init) {
          _value.text =
              _value.text.substring(0, init - 1) + _value.text.substring(end);
          controller.selection =
              TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));
        } else {
          _value.text =
              _value.text.substring(0, init) + _value.text.substring(end);
          controller.selection =
              TextSelection.fromPosition(TextPosition(offset: init));
        }
      }
      if (_value.text == "") {
        allClear();
      }
    } else if (command == '=') {
      if (isDigit(_value.text)) {
        _value.text = _value.text + _lastExpression;
      }
      updateLastExpression();
      solve();
      controller.selection =
          TextSelection.fromPosition(TextPosition(offset: _value.text.length));
    } else if (command == '( )') {
      if (init == end) {
        var cursorPos = controller.selection.base.offset != -1
            ? controller.selection.base.offset
            : _value.text.length;

        RegExp a = RegExp(r'\(');
        RegExp b = RegExp(r'\)');
        int before = a.allMatches(_value.text.substring(0, cursorPos)).length;
        int after = b.allMatches(_value.text.substring(0, cursorPos)).length;
        int cnt = 0;
        if (_value.text == '0') {
          _value.text = '(';
        } else if (_value.text[cursorPos - 1] == '(') {
          _value.text = (_value.text.substring(0, cursorPos) +
              '(' +
              _value.text.substring(cursorPos));
          cnt = 1;
        } else if (_value.text[cursorPos - 1] == ')') {
          if (before == after) {
            _value.text = (_value.text.substring(0, cursorPos) +
                'x(' +
                _value.text.substring(cursorPos));
            cnt = 2;
          } else {
            _value.text = _value.text.substring(0, cursorPos) +
                ')' +
                _value.text.substring(cursorPos);
            cnt = 1;
          }
        } else if (!isDigit(_value.text[cursorPos - 1])) {
          _value.text = (_value.text.substring(0, cursorPos) +
              '(' +
              _value.text.substring(cursorPos));
          cnt = 1;
        } else {
          if (before == after) {
            _value.text = (_value.text.substring(0, cursorPos) +
                'x(' +
                _value.text.substring(cursorPos));
            cnt = 2;
          } else {
            _value.text = (_value.text.substring(0, cursorPos) +
                ')' +
                _value.text.substring(cursorPos));
            cnt = 1;
          }
        }
        controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos + cnt));
      } else {
        String construction = _value.text.substring(0, init);
        if (init == 0 || !isDigit(_value.text[init-1])) {
          construction += '(';
        } else {
          construction += 'x(';
        }

        construction += _value.text.substring(init, end);

        if (end == _value.text.length || !isDigit(_value.text[end])) {
          construction += ')';
        } else {
          construction += ')x';
        }

        _value.text = construction + _value.text.substring(end);
        controller.selection =
            TextSelection.fromPosition(TextPosition(offset: end + 2));
      }
    } else {
      if (_value.text == '0') {
        if (isDigit(command)) {
          if (command == '00') {
          } else {
            _value.text = command;
          }
        } else if (command == '.') {
          _value.text = '0.';
        }
      } else {
        if (init == end) {
          var cursorPos = controller.selection.base.offset != -1
              ? controller.selection.base.offset
              : _value.text.length;
          _value.text = (_value.text.substring(0, cursorPos) +
              command +
              _value.text.substring(cursorPos));
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: cursorPos + command.length));
        } else {
          _value.text = _value.text.substring(0, init) +
              command +
              _value.text.substring(end);
          controller.selection =
              TextSelection.fromPosition(TextPosition(offset: init + 1));
        }
      }
    }
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
    RegExp reg = RegExp(r'[0-9]+(\.)?[0-9]*');
    if (reg.stringMatch(_value.text.substring(n)) != _value.text.substring(n)) {
      _lastExpression = _value.text.substring(n);
    }
  }

  void solve() {
    if (!isDigit(_value.text[_value.text.length - 1]) &&
        _value.text[_value.text.length - 1] != ')') {
      _value.text = _value.text.substring(0, _value.text.length - 1);
    }
    Parser p = Parser();
    Expression exp =
        p.parse(_value.text.replaceAll('x', '*').replaceAll('÷', '/'));
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
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
