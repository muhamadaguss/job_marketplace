import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/height_spacer.dart';
import '../../../common/width_spacer.dart';

List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey[300]!, blurRadius: 30, offset: const Offset(0, 10))
];

class HorizontalShimmer extends StatelessWidget {
  const HorizontalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght * .28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: 12.w,
            ),
            child: Container(
              width: width * .7,
              height: hieght * .27,
              decoration: BoxDecoration(
                color: Color(kLightGrey.value),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SkeletonAnimation(
                shimmerColor: Color(kOrange.value),
                borderRadius: BorderRadius.circular(10.r),
                shimmerDuration: 1000,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonAnimation(
                            shimmerColor: Color(kOrange.value),
                            borderRadius: BorderRadius.circular(100.r),
                            shimmerDuration: 1000,
                            child: CircleAvatar(
                              backgroundColor: Color(kLightGrey.value),
                            ),
                          ),
                          const WidthSpacer(width: 15),
                          SkeletonAnimation(
                            shimmerColor: Color(kOrange.value),
                            borderRadius: BorderRadius.circular(5.r),
                            shimmerDuration: 1000,
                            child: Container(
                              width: width * .46,
                              height: hieght * .035,
                              decoration: BoxDecoration(
                                color: Color(kLightGrey.value),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const HeightSpacer(size: 15),
                      SkeletonAnimation(
                        shimmerColor: Color(kOrange.value),
                        borderRadius: BorderRadius.circular(16.r),
                        shimmerDuration: 1000,
                        child: Container(
                          width: double.infinity,
                          height: hieght * .169,
                          decoration: BoxDecoration(
                            color: Color(kLightGrey.value),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
