import 'dart:math';

import 'package:calculator/theme/custom_key_theme.dart';
import 'package:calculator/widgets/calculator_key.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String operation = "";
  String currentNumber = "";
  String result = "0";
  bool error = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const margin = 4;

    return OrientationBuilder(builder: (context, orientation) {
      final bool isLandscape = orientation == Orientation.landscape;
      if (isLandscape) {
        final keySize = min(size.width, size.height) / 5 - 5 * margin;
        return Row(
          children: [
            Expanded(child: display()),
            const VerticalDivider(
              width: 16,
              thickness: 1,
            ),
            Expanded(child: keyPad(keySize)),
          ],
        );
      } else {
        final keySize = min(size.width, size.height) / 4 - 4 * margin;
        return Column(
          children: [
            Expanded(child: display()),
            const SizedBox(height: 8),
            keyPad(keySize),
          ],
        );
      }
    });
  }

  void addKey(String value) {
    if (error) {
      clear("");
    }
    setState(() {
      // Check if value is . and currentNumber already has a .
      if (value == "." && currentNumber.contains(".")) {
        return;
      }
      // Check if the value is a number using regex
      if (RegExp(r'[0-9\.]').hasMatch(value)) {
        currentNumber += value;
      } else {
        currentNumber = "";
      }

      operation += value;
    });
  }

  void clear(String value) {
    setState(() {
      error = false;
      operation = "";
      currentNumber = "";
    });
  }

  void compute(String value) {
    try {
      // Parse the expression string
      Parser p = Parser();
      Expression exp = p.parse(operation);

      // Create a context model (can be empty for simple expressions without variables)
      ContextModel cm = ContextModel();

      // Evaluate the expression
      error = false;

      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval == eval.toInt()) {
        // If the result is an integer, use the integer value
        result = eval.toInt().toString();
      } else {
        // If the result is not an integer, use the double value
        result = eval.toString();
      }
      operation = "";
    } catch (e) {
      operation = "Error in expression";
      error = true;
    }
    setState(() {});
  }

  Widget display() {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FittedBox(
              child: Text(
                result,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            operation,
            style: TextStyle(
              fontSize: 24,
              color: error ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget keyPad(double keySize) {
    final customTheme = context.customKeyTheme;
    return Column(
      children: [
        Row(
          children: [
            CalculatorKey(
                value: "AC",
                onTap: clear,
                height: keySize,
                backgroundColor: customTheme.acKeyBgColor,
                color: customTheme.acKeyColor),
            operatorKey(value: "(", keySize: keySize),
            operatorKey(value: ")", keySize: keySize),
            operatorKey(value: "/", keySize: keySize),
          ],
        ),
        Row(
          children: [
            numberKey(value: "7", keySize: keySize),
            numberKey(value: "8", keySize: keySize),
            numberKey(value: "9", keySize: keySize),
            operatorKey(value: "*", keySize: keySize),
          ],
        ),
        Row(
          children: [
            numberKey(value: "4", keySize: keySize),
            numberKey(value: "5", keySize: keySize),
            numberKey(value: "6", keySize: keySize),
            operatorKey(value: "-", keySize: keySize),
          ],
        ),
        Row(
          children: [
            numberKey(value: "1", keySize: keySize),
            numberKey(value: "2", keySize: keySize),
            numberKey(value: "3", keySize: keySize),
            operatorKey(value: "+", keySize: keySize),
          ],
        ),
        Row(
          children: [
            numberKey(value: "0", keySize: keySize, flex: 2),
            numberKey(value: ".", keySize: keySize),
            CalculatorKey(
                value: "=",
                onTap: compute,
                height: keySize,
                backgroundColor: customTheme.equalKeyBgColor,
                color: customTheme.equalKeyColor),
          ],
        ),
      ],
    );
  }

  Widget numberKey({required String value, required double keySize, int flex = 1}) {
    final customTheme = context.customKeyTheme;
    return CalculatorKey(
      value: value,
      onTap: addKey,
      height: keySize,
      backgroundColor: customTheme.numberKeyBgColor,
      color: customTheme.numberKeyColor,
      flex: flex,
    );
  }

  Widget operatorKey({required String value, required double keySize}) {
    final customTheme = context.customKeyTheme;
    return CalculatorKey(
      value: value,
      onTap: addKey,
      height: keySize,
      backgroundColor: customTheme.operatorKeyBgColor,
      color: customTheme.operatorKeyColor,
      borderColor: customTheme.acKeyBgColor,
    );
  }
}
