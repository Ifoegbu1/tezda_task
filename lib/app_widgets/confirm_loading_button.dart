import 'package:flutter/material.dart';
import 'package:tezda_task/app_widgets/loading_button.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_functions.dart';
import 'package:tezda_task/utils/app_colors.dart';

class ConfirmLoadingButton extends StatelessWidget {
  const ConfirmLoadingButton({
    super.key,
    required this.text,
    required this.onTap,
    this.vPad = 20,
    this.borderRadius = 12,
    this.controller,
  });

  final String text;
  final Function() onTap;
  final double? vPad;
  final double borderRadius;
  final LoadingButtonController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPad!),
      child: Center(
        child: LoadingButton(
          width: MediaQuery.of(context).size.width,

          controller: controller ?? actionButtonController,
          onPressed: onTap,
          color: AppColors.lightBlue,
          // minimumSize: const Size(403, 58),
          borderRadius: borderRadius,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   side: BorderSide(color: AppColors.fromHex('#000000')),
          // ),
          child: Text(
            text,
            style: AppStyle.txtQuicksand.copyWith(
              color: AppColors.fromHex('#E9EBED'),
              fontSize: 15.0.dynFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
