import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:job_marketplace/views/common/custom_outline_btn.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(
          kLightBlue.value,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/page3.png',
            ),
            const HeightSpacer(
              size: 20,
            ),
            ReusableText(
              text: 'Welcome JobSeeker',
              style: appstyle(30, Color(kLight.value), FontWeight.w600),
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
            const HeightSpacer(
              size: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineBtn(
                  onPressed: () async {
                    sl<SharedPreferences>()
                        .setBool('entrypoint', true)
                        .whenComplete(
                          () => Navigator.pushNamedAndRemoveUntil(
                              context, Routes.LOGIN, (route) => false),
                        );
                  },
                  text: 'Login',
                  width: width * 0.4,
                  height: hieght * 0.06,
                  color: Color(kLight.value),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.REGISTRATION, (route) => false);
                  },
                  child: Container(
                    width: width * 0.4,
                    height: hieght * 0.06,
                    color: Color(kLight.value),
                    child: Center(
                      child: ReusableText(
                        text: 'Sign Up',
                        style: appstyle(
                            16, Color(kLightBlue.value), FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const HeightSpacer(size: 30),
            ReusableText(
              text: 'Continue as guest',
              style: appstyle(
                16,
                Color(kLight.value),
                FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
