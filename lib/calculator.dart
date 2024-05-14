import 'dart:math';

import 'package:calculator/models/result.dart';
import 'package:calculator/theme/custom_key_theme.dart';
import 'package:calculator/widgets/calculator_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String operation = "";
  bool error = false;
  List<Result> results = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const margin = 4;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed('settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
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
        }),
      ),
    );
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
      String result;
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
          child: ListView.builder(
            reverse: true,
            itemCount: results.length,
            itemBuilder: (BuildContext context, int index) {
              if (results[index].operation.length + results[index].result.length < 20) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      results[index].operation,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
                    ),
                    const Text(' = '),
                    Text(
                      results[index].result,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          results[index].operation,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        results[index].result,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.secondary),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            operation.isEmpty ? "0" : operation,
            style: TextStyle(
              fontSize: 48,
              color: error ? Colors.red : null,
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
