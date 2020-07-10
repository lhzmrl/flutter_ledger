class Calculator {

  static final Operation plus = Operation(OperationValue.plus, Operation.low);
  static final Operation minus = Operation(OperationValue.minus, Operation.low);
  static final Operation multiply = Operation(
      OperationValue.multiply, Operation.high);
  static final Operation divide = Operation(
      OperationValue.divide, Operation.high);


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
      } else if(element is Operation) {
        Operation operation = element;
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
      } else if (o is Operation) {
        double number1 = calculateStack.pop();
        double number2 = calculateStack.pop();
        calculateStack.push(_calculateValue(number1, number2, o));
      }
    }
    return calculateStack.pop();
  }

  ///两个数运算
  static double _calculateValue(double number1, double number2, Operation operation) {
    if (operation.value == OperationValue.plus) {
      return number2 + number1;
    }
    if (operation.value == OperationValue.minus) {
      return number2 - number1;
    }
    if (operation.value == OperationValue.multiply) {
      return number2 * number1;
    }
    if (operation.value == OperationValue.divide) {
      return number2 / number1;
    }
    return null;
  }

  /// 算术表达式转换成操作模型 Double类表示操作数, Operation类代表操作符
  static List<Object> _getOperand(String s) {
    List<Object> list = List<Object>();
    int begin = 0;
    for (int i = 0; i < s.length; i++) {
      Object c = s[i];
      RegExp operation = new RegExp("[+\\-*/()]");
      if (operation.hasMatch(c.toString())) {
        String sub = s.substring(begin, i);
        if (sub != "") {
          list.add(double.parse(sub));
        }
        Operation operation = _parseOperation(c.toString());
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
  static Operation _parseOperation(String c) {
    if (c == OperationValue.plus.toString()) {
      return plus;
    }
    if (c == OperationValue.minus.toString()) {
      return minus;
    }
    if (c == OperationValue.multiply.toString()) {
      return multiply;
    }
    if (c == OperationValue.divide.toString()) {
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
class OperationValue {

  static OperationValue plus = OperationValue(("+"));
  static OperationValue minus = OperationValue("-");
  static OperationValue multiply = OperationValue("*");
  static OperationValue divide = OperationValue("/");

  const OperationValue(this.value);

  final String value;

  @override
  String toString() {
    return value;
  }

}

///  算术操作符类
class Operation {

  static final int low = 1;
  static final  int high = 2;

  Operation(this.value, this.priority);

  int priority;
  OperationValue value;

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