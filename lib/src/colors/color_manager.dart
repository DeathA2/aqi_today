import 'package:flutter/material.dart';

class ColorApp {
  //Gradient splash screen
  static Color startGradient = HexColor.fromHex('#85ADE6');
  static Color centerGradient = HexColor.fromHex('#85ADE6').withOpacity(0.70);
  static Color endGradient = HexColor.fromHex('#85ADE6').withOpacity(0.50);

  static Color startGradientContainer = HexColor.fromHex('#85ADE6');
  static Color endGradientContainer = HexColor.fromHex('#A5DBEC');

  static Color greenButton = HexColor.fromHex('#1CBA92');
  static Color bluePrimary = HexColor.fromHex('#0B418F');
  static Color redHeartRate = HexColor.fromHex('#F48989');
  static Color blueSPO2 = HexColor.fromHex('#8DB3EB');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = HexColor.fromHex('#000000');
  static Color greyPrimary = HexColor.fromHex('#2F3845');
  static Color greySecondary = HexColor.fromHex('#444F66');
}

extension HexColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = "FF$hex"; // 8 char with opacity 100%
    }
    return Color(int.parse(hex, radix: 16));
  }
}