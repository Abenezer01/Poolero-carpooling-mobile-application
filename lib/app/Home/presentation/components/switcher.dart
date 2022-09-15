import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  final String icon;
  final String text;
  final bool active;

  const Switcher({
    Key? key,
    required this.icon,
    required this.text,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? AppTheme.primaryColor2 : null,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        children: [
          Image.asset(icon, color: active ? AppTheme.primaryColor : Colors.black),
          Text(
            text,
            style: TextStyle(
              color: active ? AppTheme.primaryColor : null,
              fontFamily: AppTheme.primaryFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
