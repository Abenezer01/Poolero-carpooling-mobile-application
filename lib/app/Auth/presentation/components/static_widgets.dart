import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const SocialMediaIcon({required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        iconPath,
        width: 20,
        height: 20,
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: AppTheme.naturalColor2,
              height: 2.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Text(
              'OR',
              style: TextStyle(
                color: AppTheme.naturalColor2,
                fontFamily: AppTheme.primaryFont,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppTheme.naturalColor2,
              height: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
