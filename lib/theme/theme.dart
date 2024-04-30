import 'package:calculator/theme/custom_key_theme.dart';
import 'package:flutter/material.dart';

const lightBgColor = Color(0xFFf2f6f3);
const darkBgColor = Color(0xFF000000);

const lightCustomKeyTheme = CustomKeyTheme(
  numberKeyBgColor: Color(0xFFFFFFFF),
  numberKeyColor: Colors.black,
  acKeyBgColor: Color(0xFFDAE7E5),
  acKeyColor: Colors.black,
  operatorKeyBgColor: lightBgColor,
  operatorKeyColor: Colors.black,
  equalKeyBgColor: Colors.black,
  equalKeyColor: Colors.white,
);

const darkCustomKeyTheme = CustomKeyTheme(
  numberKeyBgColor: Color(0xFF121212),
  numberKeyColor: Colors.white,
  acKeyBgColor: Color(0xFF212121),
  acKeyColor: Colors.white,
  operatorKeyBgColor: darkBgColor,
  operatorKeyColor: Colors.white,
  equalKeyBgColor: Color(0xFF39C2CB),
  equalKeyColor: Colors.black,
);
