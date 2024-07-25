import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    required this.title,
    this.fontWeight = FontWeight.w400,
    this.icon,
    this.animateIcon = false,
    this.iconAsset,
    this.onTap,
  });

  final String title;
  final FontWeight? fontWeight;
  final IconData? icon;
  final bool? animateIcon;
  final String? iconAsset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (_) {
        return ListTile(
          splashColor: AppColors.lightGrey,
          onTap: onTap,
          // enabled: true,
          // titleAlignment: ListTileTitleAlignment.top,
          leading: iconAsset == null
              ? Icon(
                  icon,
                  color: AppColors.lightBlue,
                )
              : CustomImageView(
                  svgPath: iconAsset,
                ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              title,
              style: AppStyle.txtQuicksand.copyWith(
                // color: AppColors.black,
                fontWeight: fontWeight,
                fontSize: 14,
              ),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.darkGrey,
            size: 20,
          ),
        );
      },
    );
  }
}
