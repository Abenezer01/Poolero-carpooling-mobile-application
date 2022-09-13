import 'package:flutter/material.dart';

class AppTheme {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Primary Font
  static final String primaryFont = 'Nunito';

// Primary Colors
  static final Color primaryColor = fromHex('#877EF2');
  static final LinearGradient primaryColorGradient = LinearGradient(
    colors: [
      fromHex('#756AED'),
      fromHex('#A091F6'),
    ],
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(1.0, 0.0),
  );
  static final Color primaryColor2 = fromHex('#EBE9FF');

// Accent Color
  static final Color accentColor = fromHex('#FC6752');

// Natural Colors
  static final Color naturalColor1 = fromHex('#383838');
  static final Color naturalColor2 = fromHex('#50565A');
  static final Color naturalColor3 = fromHex('#77808D');
  static final Color naturalColor4 = fromHex('#BDBCBC');
  static final Color naturalColor5 = fromHex('#FFFFFF');

// Semantic Colors
  static final Color semanticColor1 = fromHex('#34DFDD');
  static final Color semanticColor2 = fromHex('#FFB461');

// Gradient Colors
  static final LinearGradient gradientColor1 = LinearGradient(
    colors: [
      fromHex('#6BF1F1'),
      fromHex('#3FD7D7'),
    ],
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(1.0, 0.0),
  );

  static final LinearGradient gradientColor2 = LinearGradient(
    colors: [
      fromHex('#FF99B5'),
      fromHex('#EC6A8F'),
    ],
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(1.0, 0.0),
  );

  // Box Shadows
  static final BoxShadow roundItemShadowColor = BoxShadow(
    color: Colors.black.withOpacity(.08),
    offset: const Offset(
      2.0,
      4.0,
    ),
    blurRadius: 16.0,
    spreadRadius: 0,
  );

  static final BoxShadow shadowColor1 = BoxShadow(
    color: fromHex('#5A4DED').withOpacity(.56),
    offset: const Offset(
      0.0,
      5.0,
    ),
    blurRadius: 20.0,
    spreadRadius: 0,
  );

  static final BoxShadow shadowColor2 = BoxShadow(
    color: fromHex('#FA8675').withOpacity(.56),
    offset: const Offset(
      0.0,
      5.0,
    ),
    blurRadius: 20.0,
    spreadRadius: 0,
  );
}
