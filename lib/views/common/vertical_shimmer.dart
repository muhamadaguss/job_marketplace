import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/width_spacer.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'height_spacer.dart';

class VerticalShimmer extends StatelessWidget {
  const VerticalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const HeightSpacer(
        size: 15,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: hieght * .15,
          width: width,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SkeletonAnimation(
            shimmerColor: Color(kOrange.value),
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SkeletonAnimation(
                        shimmerColor: Color(kOrange.value),
                        borderRadius: BorderRadius.circular(100.r),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(kLightGrey.value),
                        ),
                      ),
                      const WidthSpacer(width: 15),
                      SkeletonAnimation(
                        shimmerColor: Color(kOrange.value),
                        borderRadius: BorderRadius.circular(5.r),
                        shimmerDuration: 1000,
                        child: Container(
                          width: width * .63,
                          height: hieght * .035,
                          decoration: BoxDecoration(
                            color: Color(kLightGrey.value),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const HeightSpacer(size: 10),
                  SkeletonAnimation(
                    shimmerColor: Color(kOrange.value),
                    borderRadius: BorderRadius.circular(5.r),
                    shimmerDuration: 1000,
                    child: Container(
                      width: double.infinity,
                      height: hieght * .035,
                      decoration: BoxDecoration(
                        color: Color(kLightGrey.value),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
