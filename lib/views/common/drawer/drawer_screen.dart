import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/cubit/zoom/zoom_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/width_spacer.dart';

class DrawerScreen extends StatefulWidget {
  final ZoomDrawerController drawerController;
  const DrawerScreen({super.key, required this.drawerController});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoomCubit, ZoomState>(
      buildWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: Scaffold(
            backgroundColor: Color(kLightBlue.value),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  drawerItem(
                    context,
                    state,
                    Icons.home,
                    'Home',
                    0,
                    state.selectedIndex == 0
                        ? Color(kLight.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    context,
                    state,
                    Icons.chat_bubble_outline,
                    'Chat',
                    1,
                    state.selectedIndex == 1
                        ? Color(kLight.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    context,
                    state,
                    Icons.bookmark_border,
                    'Bookmarks',
                    2,
                    state.selectedIndex == 2
                        ? Color(kLight.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    context,
                    state,
                    Icons.devices_other_outlined,
                    'Device Mgmt',
                    3,
                    state.selectedIndex == 3
                        ? Color(kLight.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    context,
                    state,
                    FontAwesomeIcons.circleUser,
                    'Profile',
                    4,
                    state.selectedIndex == 4
                        ? Color(kLight.value)
                        : Color(kLightGrey.value),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drawerItem(BuildContext context, ZoomState state, IconData icon,
      String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        sl<ZoomCubit>().setIndex(index);
        widget.drawerController.toggle!();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          children: [
            FaIcon(
              icon,
              color: color,
            ),
            const WidthSpacer(width: 12),
            ReusableText(
              text: text,
              style: appstyle(
                12,
                color,
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
