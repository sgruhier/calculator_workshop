import 'package:flutter/material.dart';

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({
    required this.value,
    required this.height,
    required this.onTap,
    this.backgroundColor,
    this.color,
    this.borderColor,
    this.flex = 1,
    super.key,
  });
  final String value;
  final int flex;
  final double height;
  final Color? backgroundColor;
  final Color? color;
  final Color? borderColor;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
          height: height,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: backgroundColor ?? Colors.black,
            border: Border.all(color: borderColor ?? Colors.transparent, width: borderColor != null ? 1 : 0),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: height / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
