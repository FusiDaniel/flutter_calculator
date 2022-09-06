class Memory {
  String _value = '0';

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      allClear();
    } else {
      _value += command;
    }
  }

  void allClear() {
    _value = '0';
  }
}
