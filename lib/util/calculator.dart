class Calculator {

  static double tryCalculate(String expression) {
    if (expression.isEmpty) {
      return 0.0;
    }
    if (_isOperation(expression.substring(expression.length - 1))) {
      return _calculate(expression.substring(0, expression.length - 1));
    } else {
      return _calculate(expression);
    }
  }

  static bool _isOperation(String char) {
    return char == '+' || char == '-' || char == '*' || char == '/';
  }

  static double _calculate(String s) {
    return _calculateReversePolishNotation(_parse2ReversePolishNotation(s));
  }

  /// 将算术表达式转化逆波兰表达式
  static Stack<Object> _parse2ReversePolishNotation(String input) {
    String s = input.replaceAll(new RegExp(" "), "");
    final Stack<String> operationStack= Stack<String>();
    final Stack<Object> expressionStack = Stack<Object>();
  }

  /// 计算逆波兰表达式
  static double _calculateReversePolishNotation(Stack<Object> expressionStack) {
    return 0.0;
  }

}

class Stack<T> {

  final List<T> stack = List<T>();

  T pop() {
    return stack.removeLast();
  }

  push(T value) {
    stack.add(value);
  }

}