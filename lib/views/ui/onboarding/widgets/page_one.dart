import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(
          kLightPurple.value,
        ),
        child: Column(
          children: [
            const HeightSpacer(
              size: 70,
            ),
            Image.asset(
              'assets/images/page1.png',
            ),
            const HeightSpacer(
              size: 40,
            ),
            Column(
              children: [
                ReusableText(
                  text: 'Find Your Dream Job',
                  style: appstyle(
                    30,
                    Color(kLight.value),
                    FontWeight.w500,
                  ),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Text(
                    'We help you find your dream job according to your skillset, location and preference to build your career',
                    textAlign: TextAlign.center,
                    style: appstyle(
                      14,
                      Color(kLight.value),
                      FontWeight.normal,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}