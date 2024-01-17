import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:job_marketplace/api/api_client.dart';
import 'package:job_marketplace/api/remote_datasource.dart';
import 'package:job_marketplace/cubit/device_mgt/device_info_cubit.dart';
import 'package:job_marketplace/cubit/home/home_cubit.dart';
import 'package:job_marketplace/cubit/image/image_cubit.dart';
import 'package:job_marketplace/cubit/login/login_cubit.dart';
import 'package:job_marketplace/cubit/onBoarding/on_boarding_cubit.dart';
import 'package:job_marketplace/cubit/signup/signup_cubit.dart';
import 'package:job_marketplace/cubit/zoom/zoom_cubit.dart';
import 'package:job_marketplace/repositories/home_repository.dart';
import 'package:job_marketplace/repositories/job_repository.dart';
import 'package:job_marketplace/repositories/login_repository.dart';
import 'package:job_marketplace/repositories/signup_repository.dart';
import 'package:job_marketplace/repositories_impl/home_repository_impl.dart';
import 'package:job_marketplace/repositories_impl/job_repository_impl.dart';
import 'package:job_marketplace/repositories_impl/login_repository_impl.dart';
import 'package:job_marketplace/repositories_impl/signup_repository_impl.dart';
import 'package:job_marketplace/utils/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  if (!sl.isRegistered<OnBoardingCubit>()) {
    sl.registerLazySingleton<OnBoardingCubit>(() => OnBoardingCubit());
  }

  if (!sl.isRegistered<LoginCubit>()) {
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  }

  if (!sl.isRegistered<SignupCubit>()) {
    sl.registerLazySingleton<SignupCubit>(() => SignupCubit());
  }

  if (!sl.isRegistered<ZoomCubit>()) {
    sl.registerLazySingleton<ZoomCubit>(() => ZoomCubit());
  }

  if (!sl.isRegistered<DeviceInfoCubit>()) {
    sl.registerLazySingleton<DeviceInfoCubit>(() => DeviceInfoCubit());
  }

  if (!sl.isRegistered<ImageCubit>()) {
    sl.registerLazySingleton(() => ImageCubit());
  }

  if (!sl.isRegistered<HomeCubit>()) {
    sl.registerLazySingleton(() => HomeCubit());
  }

  //Repository
  if (!sl.isRegistered<LoginRepository>()) {
    sl.registerLazySingleton(
      () => LoginRepositoryImpl(
        networkInfoImpl: sl<NetworkInfoImpl>(),
        remoteDataSource: sl<RemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<HomeRepository>()) {
    sl.registerLazySingleton(
      () => HomeRepositoryImpl(
        networkInfoImpl: sl<NetworkInfoImpl>(),
        remoteDataSource: sl<RemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<SignupRepository>()) {
    sl.registerLazySingleton(
      () => SignupRepositoryImpl(
        networkInfoImpl: sl<NetworkInfoImpl>(),
        remoteDataSource: sl<RemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<JobRepository>()) {
    sl.registerLazySingleton(
      () => JobRepositoryImpl(
        networkInfoImpl: sl<NetworkInfoImpl>(),
        remoteDataSource: sl<RemoteDataSource>(),
      ),
    );
  }

  //Core
  if (!sl.isRegistered<GlobalKey<NavigatorState>>()) {
    sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  }

  if (!sl.isRegistered<ScreenUtil>()) {
    sl.registerLazySingleton(() => ScreenUtil());
  }

  if (!sl.isRegistered<ApiClient>()) {
    sl.registerLazySingleton(() => ApiClient());
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  if (!sl.isRegistered<NetworkInfoImpl>()) {
    sl.registerLazySingleton(() => NetworkInfoImpl());
  }

  if (!sl.isRegistered<RemoteDataSource>()) {
    sl.registerLazySingleton(() => RemoteDataSource());
  }
}
