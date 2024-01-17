import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/models/response/jobs/get_job.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/custom_outline_btn.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';

class JobPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const JobPage({super.key, this.arguments});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late final GetJobRes job;

  @override
  void initState() {
    if (widget.arguments != null) {
      job = widget.arguments?['data'] as GetJobRes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: job.title,
          actions: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: const FaIcon(
                  FontAwesomeIcons.bookmark,
                ),
              ),
            ),
          ],
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                const HeightSpacer(size: 10),
                Container(
                  width: width,
                  height: hieght * .27,
                  decoration: BoxDecoration(
                    color: Color(
                      kLightGrey.value,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      job.imageUrl.isEmpty
                          ? CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Color(
                                kLightGrey.value,
                              ),
                              backgroundImage: const AssetImage(
                                'assets/images/user.png',
                              ),
                            )
                          : CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(
                                job.imageUrl,
                              ),
                            ),
                      const HeightSpacer(size: 10),
                      ReusableText(
                        text: job.company,
                        style: appstyle(
                          20,
                          Color(kDark.value),
                          FontWeight.w500,
                        ),
                      ),
                      const HeightSpacer(size: 5),
                      ReusableText(
                        text: job.location,
                        style: appstyle(
                          16,
                          Color(kDarkGrey.value),
                          FontWeight.w500,
                        ),
                      ),
                      const HeightSpacer(size: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlineBtn(
                              width: width * .26,
                              height: hieght * .04,
                              text: 'Full-time',
                              color: Color(
                                kOrange.value,
                              ),
                              color2: Color(
                                kLight.value,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: job.salary,
                                  style: appstyle(
                                    16,
                                    Color(kDark.value),
                                    FontWeight.w500,
                                  ),
                                ),
                                ReusableText(
                                  text: '/',
                                  style: appstyle(
                                    16,
                                    Color(kDark.value),
                                    FontWeight.w500,
                                  ),
                                ),
                                ReusableText(
                                  text: job.period,
                                  style: appstyle(
                                    16,
                                    Color(kDark.value),
                                    FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const HeightSpacer(size: 20),
                ReusableText(
                  text: 'Job Description',
                  style: appstyle(
                    18,
                    Color(kDark.value),
                    FontWeight.w500,
                  ),
                ),
                const HeightSpacer(size: 10),
                Text(
                  job.description,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const HeightSpacer(size: 20),
                ReusableText(
                  text: 'Requirements',
                  style: appstyle(
                    18,
                    Color(kDark.value),
                    FontWeight.w500,
                  ),
                ),
                const HeightSpacer(size: 10),
                ListView.builder(
                  itemCount: job.requirements.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final req = job.requirements[index];
                    return Text(
                      '\u2022 $req\n',
                      style: appstyle(
                        16,
                        Color(kDarkGrey.value),
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    );
                  },
                ),
                const HeightSpacer(size: 20),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: CustomOutlineBtn(
                  text: 'Apply Now',
                  color: Color(kLight.value),
                  width: width,
                  height: hieght * .06,
                  color2: Color(
                    kOrange.value,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
