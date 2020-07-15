import 'package:flutter_test/flutter_test.dart';
import 'package:ledger/util/calculator.dart';

void main() {
  // 单一的测试
  test("测试表达式计算结果", () {
    final String expression = "1 + 2 - 3 + 4 - 5 + 6 -";
    double result = Calculator.tryCalculate(expression);
    print("$expression = $result");
  });
}