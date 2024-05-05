import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorKey extends StatefulWidget {
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
  State<CalculatorKey> createState() => _CalculatorKeyState();
}

class _CalculatorKeyState extends State<CalculatorKey> {
  Color? currentBackgroundColor;

  @override
  void initState() {
    super.initState();
    currentBackgroundColor = widget.backgroundColor ?? Colors.black;
  }

  void animateBackgroundColor() {
    setState(() {
      // Temporary grey color
      currentBackgroundColor = Colors.grey;
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        // Reset to original color
        currentBackgroundColor = widget.backgroundColor ?? Colors.black;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: GestureDetector(
        onTap: () {
          widget.onTap(widget.value);
          animateBackgroundColor();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          height: widget.height,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: currentBackgroundColor,
            border:
                Border.all(color: widget.borderColor ?? Colors.transparent, width: widget.borderColor != null ? 1 : 0),
          ),
          child: Center(
            child: Text(widget.value,
                style: TextStyle(
                  color: widget.color ?? Colors.white,
                  fontSize: widget.height / 2,
                )),
          ),
        ),
      ),
    );
  }
}
