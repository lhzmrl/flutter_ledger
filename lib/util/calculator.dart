class Calculator {

  static final Operator plus = Operator(OperatorValue.plus, Operator.low);
  static final Operator minus = Operator(OperatorValue.minus, Operator.low);
  static final Operator multiply = Operator(
      OperatorValue.multiply, Operator.high);
  static final Operator divide = Operator(
      OperatorValue.divide, Operator.high);


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
    final Stack<String> operationStack = Stack<String>();
    final Stack<Object> expressionStack = Stack<Object>();
    List<Object> operandList = _getOperand(s);
    operandList.forEach((element) {
      if (element is double) {
        expressionStack.push(element);
      } else if(element is String) {
        String si = element;
        if (si == "(") {
          operationStack.push(si);
        } else if (si == ")") {
          while (!(operationStack.peek() == "(")) {
            expressionStack.push(_parseOperation(operationStack.pop()));
          }
          operationStack.pop();
        }
      } else if(element is Operator) {
        Operator operation = element;
        while(!operationStack.isEmpty() && !(operationStack.peek() == "(") && operation.priority <= _parseOperation(operationStack.peek()).priority) {
          expressionStack.push(_parseOperation(operationStack.pop()));
        }
        operationStack.push(operation.value.toString());
      }
    });
    while (!(operationStack.isEmpty())) {
      expressionStack.push(_parseOperation(operationStack.pop()));
    }
    return expressionStack;
  }

  /// 计算逆波兰表达式
  static double _calculateReversePolishNotation(Stack<Object> expressionStack) {
    Stack<Object> calculateStack = Stack<Object>();
    for (int i = 0; i < expressionStack.size; i++) {
      Object o = expressionStack[i];
      if (o is double) {
        calculateStack.push(o);
      } else if (o is Operator) {
        double number1 = calculateStack.pop();
        double number2 = calculateStack.pop();
        calculateStack.push(_calculateValue(number1, number2, o));
      }
    }
    return calculateStack.pop();
  }

  ///两个数运算
  static double _calculateValue(double number1, double number2, Operator operation) {
    if (operation.value == OperatorValue.plus) {
      return number2 + number1;
    }
    if (operation.value == OperatorValue.minus) {
      return number2 - number1;
    }
    if (operation.value == OperatorValue.multiply) {
      return number2 * number1;
    }
    if (operation.value == OperatorValue.divide) {
      return number2 / number1;
    }
    return null;
  }

  static Object getLastOperand(String expression) {
    final RegExp operation = new RegExp("[+\\-*/()]");
    String lastChar = expression[expression.length - 1];
    if(operation.hasMatch(lastChar)) {
      return _parseOperation(lastChar)??lastChar;
    }
    for(int i = expression.length - 1; i >= 0; i--) {
      String c = expression[i];
      if(operation.hasMatch(c)) {
        return double.parse(expression.substring(i + 1, expression.length));
      }
    }
    return null;
  }

  static String getLastOperandString(String expression) {
    final RegExp operation = new RegExp("[+\\-*/()]");
    String lastChar = expression[expression.length - 1];
    if(operation.hasMatch(lastChar)) {
      return lastChar;
    }
    for(int i = expression.length - 1; i >= 0; i--) {
      String c = expression[i];
      if(operation.hasMatch(c)) {
        return expression.substring(i + 1, expression.length);
      }
    }
    return expression;
  }

  /// 算术表达式转换成操作模型 Double类表示操作数, Operation类代表操作符
  static List<Object> _getOperand(String s) {
    List<Object> list = List<Object>();
    int begin = 0;
    RegExp operation = new RegExp("[+\\-*/()]");
    for (int i = 0; i < s.length; i++) {
      Object c = s[i];
      if (operation.hasMatch(c.toString())) {
        String sub = s.substring(begin, i);
        if (sub != "") {
          list.add(double.parse(sub));
        }
        Operator operation = _parseOperation(c.toString());
        list.add(operation??c.toString());
        begin = i + 1;
      }
    }
    String sub = s.substring(begin);
    if (sub != "") {
      list.add(double.parse(sub));
    }
    return list;
  }

  /// 字符串转换成操作符类
  static Operator _parseOperation(String c) {
    if (c == OperatorValue.plus.toString()) {
      return plus;
    }
    if (c == OperatorValue.minus.toString()) {
      return minus;
    }
    if (c == OperatorValue.multiply.toString()) {
      return multiply;
    }
    if (c == OperatorValue.divide.toString()) {
      return divide;
    }
    return null;
  }

}

class Stack<T> {

  final List<T> _stack = List<T>();

  T pop() {
    return _stack.removeLast();
  }

  push(T value) {
    _stack.add(value);
  }

  T peek() {
    return _stack.last;
  }

  bool isEmpty() {
    return _stack.isEmpty;
  }

  T operator [](int i) {
    return _stack[i];
  }

  get size {
    return _stack.length;
  }

}

/// 操作符号枚举
class OperatorValue {

  static OperatorValue plus = OperatorValue(("+"));
  static OperatorValue minus = OperatorValue("-");
  static OperatorValue multiply = OperatorValue("*");
  static OperatorValue divide = OperatorValue("/");

  const OperatorValue(this.value);

  final String value;

  @override
  String toString() {
    return value;
  }

}

///  算术操作符类
class Operator {

  static final int low = 1;
  static final  int high = 2;

  Operator(this.value, this.priority);

  int priority;
  OperatorValue value;

  String toString() {
    return value.toString();
  }

  @override
  bool operator ==(Object other) {
    return other.hashCode == this.hashCode;
  }

  @override
  int get hashCode => super.hashCode;

}