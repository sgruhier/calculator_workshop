import 'package:flutter/material.dart';

class CustomKeyTheme extends ThemeExtension<CustomKeyTheme> {
  final Color numberKeyBgColor;
  final Color acKeyBgColor;
  final Color operatorKeyBgColor;
  final Color equalKeyBgColor;
  final Color numberKeyColor;
  final Color acKeyColor;
  final Color operatorKeyColor;
  final Color equalKeyColor;

  const CustomKeyTheme({
    required this.numberKeyBgColor,
    required this.acKeyBgColor,
    required this.operatorKeyBgColor,
    required this.equalKeyBgColor,
    required this.numberKeyColor,
    required this.acKeyColor,
    required this.operatorKeyColor,
    required this.equalKeyColor,
  });

  @override
  CustomKeyTheme copyWith({
    Color? numberKeyBgColor,
    Color? acKeyBgColor,
    Color? operatorKeyBgColor,
    Color? equalKeyBgColor,
    Color? numberKeyColor,
    Color? acKeyColor,
    Color? operatorKeyColor,
    Color? equalKeyColor,
  }) {
    return CustomKeyTheme(
      numberKeyBgColor: numberKeyBgColor ?? this.numberKeyBgColor,
      acKeyBgColor: acKeyBgColor ?? this.acKeyBgColor,
      operatorKeyBgColor: operatorKeyBgColor ?? this.operatorKeyBgColor,
      equalKeyBgColor: equalKeyBgColor ?? this.equalKeyBgColor,
      numberKeyColor: numberKeyColor ?? this.numberKeyColor,
      acKeyColor: acKeyColor ?? this.acKeyColor,
      operatorKeyColor: operatorKeyColor ?? this.operatorKeyColor,
      equalKeyColor: equalKeyColor ?? this.equalKeyColor,
    );
  }

  @override
  CustomKeyTheme lerp(ThemeExtension<CustomKeyTheme>? other, double t) {
    if (other is! CustomKeyTheme) {
      return this;
    }

    return CustomKeyTheme(
      numberKeyBgColor: Color.lerp(numberKeyBgColor, other.numberKeyBgColor, t)!,
      acKeyBgColor: Color.lerp(acKeyBgColor, other.acKeyBgColor, t)!,
      operatorKeyBgColor: Color.lerp(operatorKeyBgColor, other.operatorKeyBgColor, t)!,
      equalKeyBgColor: Color.lerp(equalKeyBgColor, other.equalKeyBgColor, t)!,
      numberKeyColor: Color.lerp(numberKeyColor, other.numberKeyColor, t)!,
      acKeyColor: Color.lerp(acKeyColor, other.acKeyColor, t)!,
      operatorKeyColor: Color.lerp(operatorKeyColor, other.operatorKeyColor, t)!,
      equalKeyColor: Color.lerp(equalKeyColor, other.equalKeyColor, t)!,
    );
  }
}

extension CustomThemeExtension on BuildContext {
  CustomKeyTheme get customKeyTheme => (Theme.of(this).extension<CustomKeyTheme>() ??
      const CustomKeyTheme(
        numberKeyBgColor: Colors.black,
        acKeyBgColor: Colors.black,
        operatorKeyBgColor: Colors.black,
        equalKeyBgColor: Colors.black,
        numberKeyColor: Colors.white,
        acKeyColor: Colors.white,
        operatorKeyColor: Colors.white,
        equalKeyColor: Colors.white,
      ));
}
