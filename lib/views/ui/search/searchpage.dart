import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(kLight.value),
        ),
        backgroundColor: Color(kOrange.value),
        elevation: 0,
        title: CustomField(
          hintText: 'Search for a job',
          controller: controller,
          suffixIcon: Padding(
            padding: EdgeInsets.all(10.h),
            child: GestureDetector(
              onTap: () {},
              child: const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/optimized_search.png',
              ),
              const HeightSpacer(size: 20),
              ReusableText(
                text: 'Start Searching For Jobs',
                style: appstyle(
                  20,
                  Color(kDark.value),
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
