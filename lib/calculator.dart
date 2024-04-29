import 'dart:math';

import 'package:calculator/models/result.dart';
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
  String result = "0";
  bool error = false;
  List<Result> results = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const margin = 4;
    return OrientationBuilder(builder: (context, orientation) {
      final bool isLandscape = orientation == Orientation.landscape;
      if (isLandscape) {
        final keySize = min(size.width, size.height) / 5 - 4 * margin;
        return Row(
          children: [
            Expanded(child: keyPad(keySize)),
            const VerticalDivider(
              width: 16,
              thickness: 1,
            ),
            Expanded(child: display()),
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
      operation += value;
    });
  }

  void clear(String value) {
    setState(() {
      error = false;
      operation = "";
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
      results.insert(0, Result(operation, result));
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
          child: ListView.separated(
            reverse: true,
            itemCount: results.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 5, thickness: 0.5, color: Colors.grey);
            },
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        results[index].operation,
                        textAlign: TextAlign.end,
                      )),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      results[index].result,
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FittedBox(
            child: Text(
              result,
              style: const TextStyle(fontSize: 48),
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
