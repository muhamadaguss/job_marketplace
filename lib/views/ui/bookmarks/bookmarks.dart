import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/drawer/drawer_widget.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:lottie/lottie.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(
          text: 'Bookmarks',
          child: DrawerWidget(),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeightSpacer(size: 100.h),
          Lottie.asset(
            'assets/json/empty_bookmark.json',
            width: 300.w,
            height: 300.h,
          ),
          HeightSpacer(size: 10.h),
          ReusableText(
            text: 'No Bookmarks',
            style: appstyle(
              16,
              Color(kDark.value),
              FontWeight.w500,
            ),
          ),
        ],
      )),
    );
  }
}
