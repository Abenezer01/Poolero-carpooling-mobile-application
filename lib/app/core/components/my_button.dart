import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String textTitle;
  final bool isPrimary;
  final bool isDisabled;
  final bool isDecline;
  final VoidCallback? onPresse;

  const MyButton(
      {Key? key,
      required this.isPrimary,
      required this.isDisabled,
      this.isDecline = false,
      this.textTitle = '',
      this.onPresse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: (isPrimary && !isDisabled) ? [AppTheme.shadowColor1] : [],
        borderRadius: BorderRadius.circular(25),
        border: (isPrimary && isDisabled) || (!isPrimary)
            ? Border.all(
                color: (isDecline)
                    ? AppTheme.accentColor
                    : (!isPrimary && !isDisabled)
                        ? AppTheme.primaryColor
                        : AppTheme.fromHex('#E1E1E1'),
                width: 1.5)
            : null,
        color: (isPrimary && isDisabled) ? AppTheme.fromHex('#E1E1E1') : null,
        gradient:
            (isPrimary && !isDisabled) ? AppTheme.primaryColorGradient : null,
      ),
      child: TextButton(
        onPressed: onPresse,
        child: Text(
          textTitle,
          style: TextStyle(
            color: (isDecline)
                ? AppTheme.accentColor
                : (isPrimary)
                    ? AppTheme.naturalColor5
                    : (!isPrimary && !isDisabled)
                        ? AppTheme.primaryColor
                        : AppTheme.fromHex('#E1E1E1'),
            fontFamily: AppTheme.primaryFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
