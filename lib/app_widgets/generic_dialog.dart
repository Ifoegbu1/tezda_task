import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_elevated_button.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class GenericDialog extends StatelessWidget {
  final IconData icon;
  final String content;
  final String confirmText;
  final String cancelText;
  final Function() onYes;
  const GenericDialog({
    super.key,
    required this.icon,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onYes,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDarkMode() ? null : Colors.white,
      // contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      actionsPadding: const EdgeInsets.only(bottom: 25, left: 17, right: 17),
      buttonPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      icon: CircleAvatar(
        maxRadius: 33,
        backgroundColor: AppColors.lightBlue,
        child: Icon(
          icon,
          size: 30,
        ),
      ),
      content: Text(
        content,
        style: AppStyle.txtQuicksand,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        CustomElevatedButton(
          backgroundColor: AppColors.containerClr(),
          // backgroundColor: const Color.fromRGBO(248, 251, 255, 1),
          // fixedSize: Size(125.0.dynW, 83.0.dynH),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(
            cancelText,
            style: AppStyle.txtQuicksand,
          ),
          onPressed: () => Get.back(),
        ),
        CustomElevatedButton(
          // fixedSize: Size(125.0.dynW, 83.0.dynH),
          pressedColor: AppColors.lightGrey,
          // padding: const EdgeInsets.only(top: 20, bottom: 20),
          // padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
          backgroundColor: AppColors.lightBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: onYes,
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
