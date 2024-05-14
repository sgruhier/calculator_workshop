import 'package:flutter/material.dart';

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({
    required this.value,
    required this.height,
    required this.onTap,
    this.flex = 1,
    super.key,
  });
  final String value;
  final int flex;
  final double height;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.black;
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
            height: height,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: backgroundColor,
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height / 2,
                ),
              ),
            )),
      ),
    );
  }
}
