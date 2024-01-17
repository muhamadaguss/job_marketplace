import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/common/width_spacer.dart';

import '../../../../models/response/jobs/get_job.dart';

class JobHorizontalTile extends StatelessWidget {
  final void Function()? onTap;
  final GetJobRes? job;
  const JobHorizontalTile({
    super.key,
    this.onTap,
    this.job,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          right: 12.w,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          width: width * .7,
          height: hieght * .27,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(kLightGrey.value),
                    backgroundImage: NetworkImage(
                      job?.imageUrl ?? '',
                    ),
                  ),
                  const WidthSpacer(width: 15),
                  Expanded(
                    child: ReusableText(
                      text: job?.company ?? '',
                      style: appstyle(
                        26,
                        Color(kDark.value),
                        FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const HeightSpacer(size: 15),
              ReusableText(
                text: job?.title ?? '',
                style: appstyle(
                  16,
                  Color(kDark.value),
                  FontWeight.w500,
                ),
              ),
              ReusableText(
                text: job?.location ?? '',
                style: appstyle(
                  16,
                  Color(kDarkGrey.value),
                  FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  ReusableText(
                    text: job?.salary.toString() ?? '',
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
                  const Spacer(),
                  CircleAvatar(
                    radius: 10.r,
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 10.sp,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
