import 'package:flutter/material.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/trip_infos.dart';

class TripCard extends StatelessWidget {
  final String avatarImg;
  final String fullName;
  final double rating;
  final int nbrFeedbacks;
  final String description;
  final Widget? body;
  final List<TripInfo>? tripInfos;
  final List<MyButton>? buttons;

  TripCard({
    Key? key,
    required this.avatarImg,
    required this.fullName,
    this.rating = 0.0,
    this.nbrFeedbacks = 0,
    this.description = '',
    this.body,
    this.tripInfos,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: size.width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        boxShadow: [AppTheme.roundItemShadowColor],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(avatarImg),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: TextStyle(
                                fontFamily: AppTheme.primaryFont,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.naturalColor1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Image.asset('assets/king.png'),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 20.0,
                              color: AppTheme.semanticColor2,
                            ),
                            SizedBox(width: 5),
                            Text(
                              rating.toString(),
                              style: TextStyle(
                                color: AppTheme.naturalColor1,
                                fontFamily: AppTheme.primaryFont,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '(${nbrFeedbacks.toString()})',
                              style: TextStyle(
                                color: AppTheme.naturalColor4,
                                fontFamily: AppTheme.primaryFont,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.drive_eta,
                              size: 18,
                              color: AppTheme.naturalColor4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty)
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppTheme.naturalColor3,
                      fontFamily: AppTheme.primaryFont,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 5),
            if (body != null)
              Container(
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: body),
              ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [for (TripInfo info in tripInfos ?? []) info],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (MyButton button in buttons ?? [])
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 40,
                      child: button,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
