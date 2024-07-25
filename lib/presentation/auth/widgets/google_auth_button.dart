import 'package:flutter/material.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/app_widgets/loading_button.dart';
import 'package:tezda_task/core/app_assets.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({
    super.key,
    required this.authCtr,
  });

  final AuthController authCtr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: LoadingButton(
          errorColor: AppColors.lightGrey,
          width: MediaQuery.of(context).size.width,
          valueColor: AppColors.lightBlue,
          successColor: AppColors.lightGrey,
          controller: googleBtnCtr,
          onPressed: () {
            authCtr.signInWithGoogle(context);
          },
          color: Colors.white, // minimumSize: const Size(403, 58),
          borderRadius: 40,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   side: BorderSide(color: AppColors.fromHex('#000000')),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomImageView(
                svgPath: AppAssets.ASSETS_ICONS_IC_GOOGLE_SVG,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                'Continue with Google',
                style: AppStyle.txtQuicksand
                    .copyWith(fontSize: 15, color: Colors.black87
                        // fontWeight: FontWeight.bold,
                        ),
              ),
            ],
          ),
        ),
      ),
      // CustomElevatedButton(
      //   onPressed: () {
      //     authCtr.signInWithGoogle();
      //   },
      //   backgroundColor: AppColors.lightGrey,
      //   minimumSize: const Size(403, 58),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     // side: BorderSide(color: AppColors.fromHex('#000000')),
      //   ),
      //   child:
      // Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CustomImageView(
      //         svgPath: AppAssets.ASSETS_ICONS_IC_GOOGLE_SVG,
      //       ),
      //       const SizedBox(
      //         width: 15,
      //       ),
      //       Text(
      //         'Continue with Google',
      //         style: theme.materialData.textTheme.bodyLarge!.copyWith(
      //           color: AppColors.darkBlue,
      //           fontSize: getFontSize(15),
      //           // fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
