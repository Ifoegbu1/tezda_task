import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_elevated_button.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/core/app_assets.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/presentation/auth/screens/login_or_register.dart';
import 'package:tezda_task/presentation/auth/widgets/google_auth_button.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final authCtr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   toolbarHeight: 10,
      //   forceMaterialTransparency: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  alignment: Alignment.center,
                  imagePath: AppAssets.ASSETS_LOGIN_IMG_PNG,
                  fit: BoxFit.cover,
                  // color: Colors.transparent,
                  showForeGDeco: true,
                  border: Border.all(color: AppColors.lightGrey.withAlpha(230)),
                  radius: BorderRadius.circular(8),
                  height: 260.0.dynH,
                  width: width,
                ),
                const Gap(10),
                Text(
                  'Find The \nBest Collections',
                  style: AppStyle.txtQuicksand
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 35),
                ),
                const Gap(20),
                Text(
                  'Get your dream item easily with Tezda \nand get other intersting offers',
                  style: AppStyle.txtQuicksand.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                const Gap(30),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomElevatedButton(
                        backgroundColor: AppColors.lightGrey,
                        fixedSize: const Size(200, 50),
                        // padding: const EdgeInsets.all(10),
                        onPressed: () {
                          Get.to(
                            () => LoginOrReg(
                              authCtr: authCtr,
                              isSignUp: true,
                            ),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: AppStyle.txtQuicksand
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      const Gap(10),
                      CustomElevatedButton(
                        fixedSize: const Size(200, 50),
                        onPressed: () {
                          Get.to(
                            () => LoginOrReg(
                              authCtr: authCtr,
                              isSignUp: false,
                            ),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: AppStyle.txtQuicksand
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                const Gap(30),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 1.5,
                        height: 10,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'or Login With',
                      style: AppStyle.txtQuicksand.copyWith(color: Colors.grey),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 10,
                        thickness: 1.5,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
                // CustomElevatedButton(
                //     margin: const EdgeInsets.only(top: 20),
                //     // alignment: Alignment.center,
                //     backgroundColor: Colors.white,
                //     // fixedSize: const Size(200, 50),
                //     onPressed: () {},
                //     child: Center(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const CustomImageView(
                //             fit: BoxFit.scaleDown,
                //             imagePath: AppAssets.ASSETS_ICONS_G_PNG,
                //             width: 50,
                //             height: 50,
                //           ),
                //           Text(
                //             'Continue with Google',
                //             style: AppStyle.txtQuicksand
                //                 .copyWith(color: AppColors.black),
                //           ),
                //         ],
                //       ),
                //     )),

                GoogleAuthButton(authCtr: authCtr),
                CustomElevatedButton(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(5),
                  // margin: const EdgeInsets.symmetric(vertical: 20),
                  // alignment: Alignment.center,
                  backgroundColor: Colors.white,
                  // fixedSize: const Size(200, 50),
                  onPressed: () {},
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          size: 40,
                          color: AppColors.black,
                        ),
                        Text(
                          'Continue with Apple',
                          style: AppStyle.txtQuicksand
                              .copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
