import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_marketplace/cubit/zoom/zoom_cubit.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/ui/auth/profile.dart';
import 'package:job_marketplace/views/ui/bookmarks/bookmarks.dart';
import 'package:job_marketplace/views/ui/chat/chatpage.dart';
import 'package:job_marketplace/views/ui/device_mgt/devices_info.dart';
import 'package:job_marketplace/views/ui/homepage.dart';

import '../common/drawer/drawer_screen.dart';

final ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoomCubit, ZoomState>(
      buildWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex,
      builder: (context, state) {
        return ZoomDrawer(
          controller: z,
          borderRadius: 24,
          showShadow: true,
          openCurve: Curves.easeInOutExpo,
          // slideWidth: MediaQuery.of(context).size.width * 0.65,
          duration: const Duration(milliseconds: 500),
          angle: 0.0,
          menuBackgroundColor: Color(kLightBlue.value),
          mainScreen: currentScreen(state),
          moveMenuScreen: false,
          menuScreen: DrawerScreen(
            drawerController: z,
          ),
        );
      },
    );
  }

  Widget currentScreen(ZoomState state) {
    switch (state.selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatsPage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagement();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
