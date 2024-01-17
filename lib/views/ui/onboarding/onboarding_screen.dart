import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/cubit/onBoarding/on_boarding_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/ui/onboarding/widgets/page_one.dart';
import 'package:job_marketplace/views/ui/onboarding/widgets/page_three.dart';
import 'package:job_marketplace/views/ui/onboarding/widgets/page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        buildWhen: (previous, current) =>
            previous.isLastPage != current.isLastPage,
        builder: (context, state) {
          return Stack(
            children: [
              PageView(
                physics: state.isLastPage == true
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {
                  sl<OnBoardingCubit>().lastPage(value == 2);
                },
                children: const [
                  PageOne(),
                  PageTwo(),
                  PageThree(),
                ],
              ),
              state.isLastPage == true
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: hieght * 0.12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: WormEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            spacing: 10,
                            dotColor: Color(kDarkBlue.value).withOpacity(
                              0.5,
                            ),
                            activeDotColor: Color(
                              kLight.value,
                            ),
                          ),
                        ),
                      ),
                    ),
              state.isLastPage == true
                  ? const SizedBox.shrink()
                  : Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 30.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                },
                                child: ReusableText(
                                  text: 'skip',
                                  style: appstyle(
                                    16,
                                    Color(kLight.value),
                                    FontWeight.normal,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                },
                                child: ReusableText(
                                  text: 'next',
                                  style: appstyle(
                                    16,
                                    Color(kLight.value),
                                    FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
