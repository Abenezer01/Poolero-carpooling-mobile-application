import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car? car;
  final String image;
  final VoidCallback onTap;

  const CarCard({
    this.car,
    this.image = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.09),
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 56,
              child: Image.asset(image),
            ),
          ),
          if (car != null)
            Column(
              children: [
                Text(
                  car!.mark.name,
                  style: TextStyle(
                    color: AppTheme.naturalColor2,
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  car!.model.name,
                  style: TextStyle(
                    color: AppTheme.naturalColor4,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
