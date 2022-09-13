import 'package:flutter/material.dart';
import 'package:carpooling_beta/app/core/theme.dart';

class TripInfo extends StatelessWidget {
  final String icon;
  final String info;
  final String label;

  const TripInfo(
      {Key? key, required this.icon, required this.info, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [Image.asset(icon)],
            ),
            SizedBox(width: 7),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: TextStyle(
                    color: AppTheme.naturalColor1,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.naturalColor4,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
