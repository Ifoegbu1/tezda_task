import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

showElegantNotif(
  BuildContext context, {
  required String title,
  required String description,
  required NotificationType elegantNotifType,
  bool isNotificationTop = true,
  Duration toastDuration = const Duration(seconds: 5),
  Function()? onProgressFinished,
  Function()? onDescriptionTap,
  bool autoDismiss = true,
  double height = 80,
  FontWeight? descriptionFontWt,
}) {
  // Color bgClr = Colors.white;
  Color bgClr = AppColors.elegantNotifBgCLr();
  return elegantNotifType == NotificationType.error
      ? ElegantNotification.error(
          toastDuration: toastDuration,
          onProgressFinished: onProgressFinished,
          background: bgClr,
          height: height,
          animation: AnimationType.fromRight,
          position:
              isNotificationTop ? Alignment.topRight : Alignment.bottomRight,
          width: 300,
          title: Text(
            title,
            style: AppStyle.txtQuicksand.copyWith(
                // fontWeight: FontWeight.w,
                // fontSize: 14,
                ),
          ),
          description: GestureDetector(
            onTap: onDescriptionTap,
            child: Text(
              description,
              maxLines: 6,
              style: AppStyle.txtQuicksand.copyWith(
                fontSize: 12.0.dynFont,
              ),
            ),
          ),
        ).show(context)
      : elegantNotifType == NotificationType.success
          ? ElegantNotification.success(
              toastDuration: toastDuration,
              animation: AnimationType.fromRight,
              position: isNotificationTop
                  ? Alignment.topRight
                  : Alignment.bottomRight,
              onProgressFinished: onProgressFinished,
              background: bgClr,
              height: 80,
              width: 300,
              title: Text(
                title,
                style: AppStyle.txtQuicksand.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              description: GestureDetector(
                onTap: onDescriptionTap,
                child: Text(
                  description,
                  maxLines: 6,
                  style: AppStyle.txtQuicksand.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ).show(context)
          : ElegantNotification.info(
              background: bgClr,
              onProgressFinished: onProgressFinished,
              animation: AnimationType.fromRight,
              position: isNotificationTop
                  ? Alignment.topRight
                  : Alignment.bottomRight,
              height: 80,
              width: 300,
              title: Text(
                title,
                style: AppStyle.txtQuicksand.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              description: GestureDetector(
                onTap: onDescriptionTap,
                child: Text(
                  description,
                  maxLines: 6,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
            ).show(context);
}

firebaseErrorCode(BuildContext context, String code) {
  if (code == 'weak-password') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Weak Password',
      description: 'Your password is weak. Enter a strong password',
    );
  } else if (code == 'email-already-in-use') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'User already exist',
      description:
          'Account already exist for the email. Please contact the admin',
    );
  } else if (code == 'provider-already-linked') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Already linked',
      description: "User has already been linked to the given provider",
    );
  } else if (code == 'credential-already-in-use') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Number unavailable',
      description: 'This number is linked to another user',
    );
  } else if (code == 'user-not-found') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'User not found',
      description: 'No user found for the email.',
    );
  } else if (code == 'network-request-failed') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Internet',
      description: 'Please check your connection and try again.',
    );
  } else if (code == 'too-many-requests') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Too many requests',
      description: 'You have made too many request. Please try again later',
    );
  } else if (code == 'session-expired') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Expires',
      description: 'Session expired, try again.',
    );
  } else if (code == 'user-disabled') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Unautharisation',
      description: 'Unathorisation, please contact the admin',
    );
  } else if (code == 'wrong-password') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Invalid',
      description: 'Invalid credential, please try again.',
    );
  } else if (code == 'invalid-email') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Invalid',
      description: 'Invalid email, please try again.',
    );
  } else if (code == 'invalid-phone-number') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Invalid phone number',
      description: 'The provided phone number is not valid',
    );
  } else if (code == 'invalid-verification-code') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Invalid token ',
      description: 'The provided token is not valid',
    );
  } else if (code == 'invalid-credential') {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Invalid credential ',
      description: 'The provided email or password is incorrect',
    );
  } else {
    showElegantNotif(
      context,
      elegantNotifType: NotificationType.error,
      title: 'Error',
      description: 'Error occured! Try again.',
    );
  }
}

ToastFuture showAnimToast(BuildContext context, String msg) {
  return showToast(
    msg,
    textStyle: AppStyle.txtQuicksand.copyWith(fontSize: 14),
    shapeBorder: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.lightBlue, width: 1.5),
      borderRadius: BorderRadius.circular(10),
    ),
    // textStyle: AppStyle.txtQuicksand.copyWith(color: Colors.white),
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    animation: StyledToastAnimation.sizeFade,
  );
}
