import 'dart:math';

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
    final keySize = min(size.width, size.height) / 4 - 4 * margin;
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
        const SizedBox(height: 8),
        Row(
          children: [
            CalculatorKey(value: "AC", onTap: clear, height: keySize),
            CalculatorKey(value: "(", onTap: addKey, height: keySize),
            CalculatorKey(value: ")", onTap: addKey, height: keySize),
            CalculatorKey(value: "/", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "7", onTap: addKey, height: keySize),
            CalculatorKey(value: "8", onTap: addKey, height: keySize),
            CalculatorKey(value: "9", onTap: addKey, height: keySize),
            CalculatorKey(value: "*", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "4", onTap: addKey, height: keySize),
            CalculatorKey(value: "5", onTap: addKey, height: keySize),
            CalculatorKey(value: "6", onTap: addKey, height: keySize),
            CalculatorKey(value: "-", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "1", onTap: addKey, height: keySize),
            CalculatorKey(value: "2", onTap: addKey, height: keySize),
            CalculatorKey(value: "3", onTap: addKey, height: keySize),
            CalculatorKey(value: "+", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "0", onTap: addKey, height: keySize, flex: 2),
            CalculatorKey(value: ".", onTap: addKey, height: keySize),
            CalculatorKey(value: "=", onTap: compute, height: keySize),
          ],
        ),
      ],
    );
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
    return Column(
      children: [
        Row(
          children: [
            CalculatorKey(value: "AC", onTap: clear, height: keySize),
            CalculatorKey(value: "(", onTap: addKey, height: keySize),
            CalculatorKey(value: ")", onTap: addKey, height: keySize),
            CalculatorKey(value: "/", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "7", onTap: addKey, height: keySize),
            CalculatorKey(value: "8", onTap: addKey, height: keySize),
            CalculatorKey(value: "9", onTap: addKey, height: keySize),
            CalculatorKey(value: "*", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "4", onTap: addKey, height: keySize),
            CalculatorKey(value: "5", onTap: addKey, height: keySize),
            CalculatorKey(value: "6", onTap: addKey, height: keySize),
            CalculatorKey(value: "-", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "1", onTap: addKey, height: keySize),
            CalculatorKey(value: "2", onTap: addKey, height: keySize),
            CalculatorKey(value: "3", onTap: addKey, height: keySize),
            CalculatorKey(value: "+", onTap: addKey, height: keySize),
          ],
        ),
        Row(
          children: [
            CalculatorKey(value: "0", onTap: addKey, height: keySize, flex: 2),
            CalculatorKey(value: ".", onTap: addKey, height: keySize),
            CalculatorKey(value: "=", onTap: compute, height: keySize),
          ],
        ),
      ],
    );
  }
}
