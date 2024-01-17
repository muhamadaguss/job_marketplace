import 'package:flutter/cupertino.dart';
import 'package:job_marketplace/views/ui/auth/login.dart';
import 'package:job_marketplace/views/ui/auth/signup.dart';
import 'package:job_marketplace/views/ui/auth/update_user.dart';
import 'package:job_marketplace/views/ui/jobs/job_page.dart';
import 'package:job_marketplace/views/ui/mainscreen.dart';
import 'package:job_marketplace/views/ui/onboarding/onboarding_screen.dart';
import 'package:job_marketplace/views/ui/search/searchpage.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.ONBOARDINGSCREEN;

  static Route<dynamic> generateRoute(final RouteSettings settings) {
    final arguments =
        (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

    return CupertinoPageRoute<dynamic>(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case Routes.ONBOARDINGSCREEN:
            return const OnBoardingScreen();
          case Routes.LOGIN:
            return const LoginPage();
          case Routes.REGISTRATION:
            return const RegistrationPage();
          case Routes.PERSONALDETAILS:
            return PersonalDetails(
              arguments: arguments,
            );
          case Routes.MAINSCREEN:
            return const MainScreen();
          case Routes.SEARCH:
            return const SearchPage();
          case Routes.JOB:
            return JobPage(
              arguments: arguments,
            );
          default:
            return const OnBoardingScreen();
        }
      },
    );
  }
}
