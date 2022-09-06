import 'package:math_expressions/math_expressions.dart';

class Memory {
  String _lastExpression = '';
  String _value = '0';

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      allClear();
    } else if (command == '=') {
      if (isDigit(_value)) {
        _value = _value + _lastExpression;
      }
      print(_lastExpression);
      solve();
    } else {
      if (_value == '0') {
        if (isDigit(command)) {
          _value = command;
        }
      } else {
        _value = (_value + command);
      }
    }
    updateLastExpression();
  }

  void allClear() {
    _value = '0';
    _lastExpression = '';
  }

  void updateLastExpression() {
    int n = _value.length - 1;

    while (n > 0 &&
        (isDigit(_value[n]) || _value[n] == '.')) {
      n--;
    }
    // print('value: $_value');
    // print('n: $n');
    RegExp reg = RegExp(r'[0-9]+(\.)?[0-9]*');
    print('s ${reg.stringMatch(_value.substring(n))}');
    print('b ${_value.substring(n)}');
    if (reg.stringMatch(_value.substring(n)) != _value.substring(n)) {
      _lastExpression = _value.substring(n);
    }
    // print("le: $_lastExpression");
  }

  void solve() {
    if (!isDigit(_value[_value.length - 1])) {
      _value = _value.substring(0, _value.length - 1);
    }

    Parser p = Parser();
    Expression exp = p.parse(_value
        .replaceAll('x', '*')
        .replaceAll('÷', '/'));
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    // print(eval);
    _value = removeZeros(eval.toString());
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
