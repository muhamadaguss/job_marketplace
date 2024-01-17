import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/bloc_provider.dart';
import 'package:job_marketplace/constants/app_constants.dart';
import 'package:job_marketplace/firebase_options.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../injector_container.dart' as di;

String defaultHome = AppPages.INITIAL;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final isLogin = prefs.getBool('isLogin') ?? false;
  final entrypoint = prefs.getBool('entrypoint') ?? false;
  if (entrypoint && !isLogin) {
    defaultHome = Routes.LOGIN;
  } else if (entrypoint && isLogin) {
    defaultHome = Routes.MAINSCREEN;
  }
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(
                color: Color(kDark.value),
              ),
              primarySwatch: Colors.grey,
            ),
            onGenerateRoute: AppPages.generateRoute,
            initialRoute: defaultHome,
            navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
          );
        },
      ),
    );
  }
}
