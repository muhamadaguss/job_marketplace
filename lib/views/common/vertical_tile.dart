import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/width_spacer.dart';

import '../../models/response/jobs/get_job.dart';

class VerticalTile extends StatelessWidget {
  final void Function()? onTap;
  final GetJobRes? job;
  const VerticalTile({super.key, this.onTap, this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        height: hieght * .15,
        width: width,
        decoration: BoxDecoration(
          color: Color(kLightGrey.value),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(kLightGrey.value),
                  backgroundImage: NetworkImage(
                    job?.imageUrl ?? '',
                  ),
                ),
                const WidthSpacer(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: job?.company ?? '',
                      style: appstyle(20, Color(kDark.value), FontWeight.w500),
                    ),
                    SizedBox(
                      width: width * .5,
                      child: ReusableText(
                        text: job?.title ?? '',
                        style: appstyle(
                            20, Color(kDarkGrey.value), FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: Color(kLight.value),
                  child: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Color(kDark.value),
                    size: 15.sp,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReusableText(
                    text: job?.salary ?? '',
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w500),
                  ),
                  ReusableText(
                    text: '/',
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w500),
                  ),
                  ReusableText(
                    text: job?.period ?? '',
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
