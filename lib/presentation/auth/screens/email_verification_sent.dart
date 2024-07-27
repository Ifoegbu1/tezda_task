import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:tezda_task/app_widgets/custom_elevated_button.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class EmailSentVerificationScreen extends StatefulWidget {
  const EmailSentVerificationScreen({super.key});

  @override
  State<EmailSentVerificationScreen> createState() =>
      _EmailSentVerificationScreenState();
}

class _EmailSentVerificationScreenState
    extends State<EmailSentVerificationScreen> {
  final authCtr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'email',
              child: Center(
                child: Icon(
                  Icons.email_rounded,
                  color: AppColors.lightBlue,
                  size: 80,
                ),
              ),
            ),
            SizedBox(
              height: 80.0.dynH,
            ),
            Text(
              "Check Your Mail",
              style: AppStyle.txtQuicksand.copyWith(
                // color: Colors.black,
                fontSize: 25.0.dynFont,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "We've sent you an email verification",
              textAlign: TextAlign.center,
              style: AppStyle.txtQuicksand
                  .copyWith(fontSize: 20.0.dynFont, color: Colors.grey),
            ),
            SizedBox(height: 150.0.dynH),
            CustomElevatedButton(
              backgroundColor: AppColors.lightBlue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              minimumSize: const Size(200, 50),
              onPressed: () async {
                await OpenMailApp.openMailApp();
              },
              child: Text(
                'Open Email App',
                style: AppStyle.txtQuicksand.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                authCtr.checkVerification(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Verified?',
                    style: AppStyle.txtQuicksand
                        .copyWith(color: AppColors.sizeTxtClr()),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Click Here',
                    style: AppStyle.txtQuicksand.copyWith(
                      color: AppColors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
