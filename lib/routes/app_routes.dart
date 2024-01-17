// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const ONBOARDINGSCREEN = _Paths.ONBOARDINGSCREEN;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTRATION = _Paths.REGISTRATION;
  static const MAINSCREEN = _Paths.MAINSCREEN;
  static const SEARCH = _Paths.SEARCH;
  static const JOB = _Paths.JOB;
  static const PERSONALDETAILS = _Paths.PERSONALDETAILS;
}

abstract class _Paths {
  _Paths._();
  static const ONBOARDINGSCREEN = '/onboardingscreen';
  static const LOGIN = '/login';
  static const REGISTRATION = '/registration';
  static const MAINSCREEN = '/mainscreen';
  static const SEARCH = '/search';
  static const JOB = '/job';
  static const PERSONALDETAILS = '/personaldetails';
}
