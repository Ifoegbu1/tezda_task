import 'package:flutter/material.dart';
import 'package:tezda_task/app_widgets/custom_elevated_button.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';

class AccountInactiveDialog extends StatefulWidget {
  final Function() onClickVerify;
  const AccountInactiveDialog({
    super.key,
    required this.onClickVerify,
  });

  @override
  State<AccountInactiveDialog> createState() => _AccountInactiveDialogState();
}

class _AccountInactiveDialogState extends State<AccountInactiveDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: Icon(
        Icons.no_accounts,
        size: 40,
        color: AppColors.lightBlue,
      ),
      title: Text(
        "You haven't verified this email yet!",
        textAlign: TextAlign.center,
        style: AppStyle.txtQuicksand.copyWith(
            // fontSize: 13
            ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        CustomElevatedButton(
          // padding: const EdgeInsets.all(5),
          // backgroundColor: AppColors.dialogBtnClr(),
          onPressed: () => Navigator.of(context).pop(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            'Maybe Later',
            style: AppStyle.txtQuicksand.copyWith(
              // color: AppColors.txtClr(),
              fontSize: 14,
            ),
          ),
        ),
        CustomElevatedButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: widget.onClickVerify,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Text(
            'Verify Now',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
