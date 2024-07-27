import 'dart:async';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/core/app_assets.dart';
import 'package:tezda_task/core/app_routes.dart';
import 'package:tezda_task/core/generics.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/home/home.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';
import 'package:tezda_task/presentation/user/user_page.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class FluidBottomBar extends StatefulWidget {
  const FluidBottomBar({super.key});

  @override
  State createState() {
    return _FluidBottomBarState();
  }
}

class _FluidBottomBarState extends State with SingleTickerProviderStateMixin {
  Widget? _child;
  final homeCtr = Get.find<HomeController>();
  final authCtr = Get.find<AuthController>();
  late StreamSubscription<User?> authStateSubscription;

  @override
  void initState() {
    homeCtr.getProducts();

    _child = const Home(
      isFav: false,
    );

    authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        tezdaLog('user logged out');
        Get.offAllNamed(AppRoutes.auth);

        if (!authCtr.wantsToLogOut) {
          showElegantNotif(
            context,
            title: 'Authentication',
            description: 'Session expired',
            elegantNotifType: NotificationType.error,
          );
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    // Build a simple container that swituches content based of off the selected navigation item
    return DoubleBack(
      background: AppColors.lightGrey,
      textStyle: AppStyle.txtQuicksand.copyWith(color: Colors.black87),
      message: "Press back again to exit app",
      child: GetBuilder<UserController>(builder: (_) {
        return Scaffold(
          // primary: true,
          // backgroundColor: Colors.transparent,
          extendBody: true,
          body: _child!,
          bottomNavigationBar: FluidNavBar(
            icons: [
              FluidNavBarIcon(
                svgPath: AppAssets.ASSETS_ICONS_HOME_SVG,
                backgroundColor: Colors.transparent,

                // backgroundColor: Color(0xFF4285F4),
                extras: {"label": "home"},
              ),
              FluidNavBarIcon(
                icon: CupertinoIcons.heart,
                backgroundColor: Colors.transparent,
                // backgroundColor: Color(0xFFEC4134)
                extras: {"label": "favorites"},
              ),
              FluidNavBarIcon(
                svgPath: AppAssets.ASSETS_ICONS_SHOPPING_BAG_SVG,
                backgroundColor: Colors.transparent,

                // backgroundColor: Color(0xFFFCBA02),
                extras: {"label": "cart"},
              ),
              FluidNavBarIcon(
                svgPath: AppAssets.ASSETS_ICONS_USER_SVG,
                backgroundColor: Colors.transparent,

                // backgroundColor: Color(0xFF34A950),
                extras: {"label": "person"},
              ),
            ],
            onChange: _handleNavigationChange,
            style: FluidNavBarStyle(
                iconUnselectedForegroundColor: AppColors.bottomBarIconClr(),
                iconSelectedForegroundColor: AppColors.lightBlue,
                // barBackgroundColor: AppColors.lightGrey.withOpacity(0.5),

                //          // iconUnselectedForegroundColor: Colors.white,
                // iconSelectedForegroundColor: AppColors.lightBlue,
                barBackgroundColor: AppColors.bottomBarBgClr(),),
            scaleFactor: 1,
            defaultIndex: 0,
            itemBuilder: (icon, item) => Semantics(
              label: icon.extras!["label"],
              child: item,
            ),
          ),
        );
      },),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const Home(
            isFav: false,
          );
          break;

        case 1:
          _child = _child = const Home(
            isFav: true,
          );

          break;
        case 2:
          _child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomImageView(
                  margin: EdgeInsets.all(20),
                  // height: 200,
                  // width: 20,
                  imagePath: AppAssets.ASSETS_EMPTY_CART_PNG,
                ),
                Text(
                  'Your cart is Empty',
                  style: AppStyle.txtQuicksand.copyWith(color: Colors.grey),
                ),
              ],
            ),
          );
          break;
        case 3:
          _child = const AccountPage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
