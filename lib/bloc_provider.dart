import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_marketplace/cubit/device_mgt/device_info_cubit.dart';
import 'package:job_marketplace/cubit/home/home_cubit.dart';
import 'package:job_marketplace/cubit/image/image_cubit.dart';
import 'package:job_marketplace/cubit/login/login_cubit.dart';
import 'package:job_marketplace/cubit/onBoarding/on_boarding_cubit.dart';
import 'package:job_marketplace/cubit/signup/signup_cubit.dart';
import 'package:job_marketplace/cubit/zoom/zoom_cubit.dart';
import 'package:job_marketplace/injector_container.dart';

List<BlocProvider> get providers => [
      BlocProvider<OnBoardingCubit>(
        create: (context) => sl<OnBoardingCubit>(),
      ),
      BlocProvider<LoginCubit>(
        create: (context) => sl<LoginCubit>(),
      ),
      BlocProvider<SignupCubit>(
        create: (context) => sl<SignupCubit>(),
      ),
      BlocProvider<ZoomCubit>(
        create: (context) => sl<ZoomCubit>(),
      ),
      BlocProvider<DeviceInfoCubit>(
        create: (context) => sl<DeviceInfoCubit>(),
      ),
      BlocProvider<ImageCubit>(
        create: (context) => sl<ImageCubit>(),
      ),
      BlocProvider<HomeCubit>(
        create: (context) => sl<HomeCubit>(),
      ),
    ];
