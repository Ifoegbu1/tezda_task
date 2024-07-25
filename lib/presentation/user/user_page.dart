import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/app_widgets/custom_photoview.dart';
import 'package:tezda_task/core/generics.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';
import 'package:tezda_task/presentation/user/screens/profile_screen.dart';
import 'package:tezda_task/presentation/user/widgets/logout_dialog.dart';
import 'package:tezda_task/presentation/user/widgets/user_item.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (_) {
        final userCtr = Get.find<UserController>();
        final authCtr = Get.find<AuthController>();

        User user = userCtr.user;
        return ThemeSwitchingArea(
          child: Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              toolbarHeight: 10,
            ),
            // extendBody: true,
            // extendBodyBehindAppBar: true,
            // backgroundColor: isDarkMode() ? null : AppColors.fromHex('#FBFAFA'),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      width: context.width,
                      decoration: BoxDecoration(
                        // color:
                        //     isDarkMode() ? null : AppColors.fromHex('#FBFAFA'),
                        border: Border(
                          bottom: BorderSide(
                            color:
                                AppColors.fromHex('#1C3454').withOpacity(0.26),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 130.0.dynH,
                                  width: 140.0.dynW,
                                  child: Hero(
                                    tag: 'acct-pic',
                                    child: FittedBox(
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.lightBlue,
                                        child: CustomImageView(
                                          isProfile: true,
                                          fit: BoxFit.cover,
                                          url: user.photoURL,
                                          height: 130.0.dynH,
                                          width: user.photoURL != null
                                              ? 140.0.dynW
                                              : 50,
                                          radius: BorderRadius.circular(40),
                                          onTap: () {
                                            Get.to(
                                              () => CustomPhotoView(
                                                photoUrl: user.photoURL!,
                                                heroTag: 'acct-pic',
                                              ),
                                              transition:
                                                  Transition.noTransition,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  user.displayName!,
                                  style: AppStyle.txtQuicksand.copyWith(
                                    color: AppColors.lightBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  user.email!,
                                  style: AppStyle.txtQuicksand.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 0,
                            child: ThemeSwitcher(
                              clipper: const ThemeSwitcherCircleClipper(),
                              builder: (context) {
                                return IconButton(
                                  highlightColor: AppColors.lightGrey,
                                  onPressed: userCtr.coolDown
                                      ? null
                                      : () async {
                                          userCtr.changeTheme(context);
                                        },
                                  icon: Icon(
                                    isDarkMode()
                                        ? Icons.nights_stay
                                        : Icons.light_mode_rounded,
                                    color: isDarkMode()
                                        ? null
                                        : AppColors.lightBlue,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountItem(
                          onTap: () {
                            Get.to(
                                () => ProfileScreen(
                                      userCtr: userCtr,
                                      isFromAcc: true,
                                    ),
                                transition: Transition.rightToLeft);
                          },
                          title: 'My Profile',
                          icon: CupertinoIcons.person_crop_circle_fill,
                        ),
                        const AccountItem(
                          title: 'Refer Friends',
                          icon: Icons.share,
                        ),
                        const AccountItem(
                          title: 'Reviews',
                          icon: Icons.star,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20),
                          child: Text(
                            "Help",
                            style: AppStyle.txtQuicksand
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        const AccountItem(
                          title: 'Contact Us',
                          icon: Icons.support_agent,
                        ),
                        const AccountItem(
                          title: 'Notifications',
                          icon: Icons.notifications,
                        ),
                        const AccountItem(
                          title: 'Helpline Number',
                          icon: Icons.phone_in_talk,
                        ),
                        AccountItem(
                          title: 'Check For updates',
                          icon: Icons.update_rounded,
                          onTap: () {
                            showAnimToast(context,
                                'Great you are on the latest version!');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20),
                          child: Text(
                            "Security",
                            style: AppStyle.txtQuicksand
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        const AccountItem(
                          title: 'Change Password',
                          icon: Icons.lock,
                        ),
                        AccountItem(
                          title: 'Log Out',
                          icon: Icons.logout,
                          onTap: () {
                            Get.dialog(
                              LogoutDialog(
                                onYes: () {
                                  authCtr.logout();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
