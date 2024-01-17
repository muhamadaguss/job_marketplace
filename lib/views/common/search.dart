import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/common/width_spacer.dart';

class SearchWidget extends StatelessWidget {
  final void Function()? onTap;
  const SearchWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Color(kOrange.value),
                      size: 20,
                    ),
                    const WidthSpacer(width: 20),
                    ReusableText(
                      text: 'Search for jobs',
                      style:
                          appstyle(18, Color(kOrange.value), FontWeight.w500),
                    ),
                  ],
                ),
              ),
              FaIcon(
                FontAwesomeIcons.sliders,
                color: Color(kDarkGrey.value),
                size: 20,
              ),
            ],
          ),
          const HeightSpacer(size: 7),
          Divider(
            color: Color(kLightGrey.value),
            thickness: 0.5,
            endIndent: 40.w,
          ),
        ],
      ),
    );
  }
}
