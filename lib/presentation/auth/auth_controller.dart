import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tezda_task/app_widgets/loading_button.dart';
import 'package:tezda_task/core/app_routes.dart';
import 'package:tezda_task/core/generics.dart';
import 'package:tezda_task/core/services/storage_service.dart';
import 'package:tezda_task/presentation/auth/screens/email_verification_sent.dart';
import 'package:tezda_task/presentation/auth/screens/login_or_register.dart';
import 'package:tezda_task/presentation/auth/widgets/account_inactive_dialog.dart';
import 'package:tezda_task/utils/app_functions.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth;
  bool wantsToLogOut = false;
  User? user;

  late TextEditingController emailTxtCtr;
  late TextEditingController passwordCtr;
  late TextEditingController nameTxtCtr;
  AuthController({
    required this.firebaseAuth,
  });

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void initCtr() {
    emailTxtCtr = TextEditingController();
    passwordCtr = TextEditingController();
    nameTxtCtr = TextEditingController();
  }

  void disposeCtr() {
    emailTxtCtr.dispose();
    passwordCtr.dispose();
    nameTxtCtr.dispose();
  }

  void signUpWithEmail(
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTxtCtr.text, password: passwordCtr.text);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.updateDisplayName(nameTxtCtr.text);
        await user.sendEmailVerification().then((value) async {
          delayedFunc(
              () => Get.to(() => const EmailSentVerificationScreen(),
                  transition: Transition.noTransition),
              2.seconds);
        });

        buttonStatus(
          buttonStatusType: ButtonState.success,
          buttonController: actionButtonController,
        );
      } else {
        buttonStatus(
          buttonStatusType: ButtonState.error,
          buttonController: actionButtonController,
        );
      }
    } on FirebaseAuthException catch (e) {
      buttonStatus(
        buttonStatusType: ButtonState.error,
        buttonController: actionButtonController,
      );
      if (context.mounted) firebaseErrorCode(context, e.code);
    } catch (e) {
      buttonStatus(
        buttonStatusType: ButtonState.error,
        buttonController: actionButtonController,
      );
      tezdaLog(e);
    }
  }

  Future<void> checkVerification(
      BuildContext context, String signUpMethod) async {
    final user = firebaseAuth.currentUser;
    user!.reload();

    if (user.emailVerified) {
      showElegantNotif(context,
          title: 'Verification',
          description: 'Email verification succesful',
          elegantNotifType: NotificationType.success);

      Get.to(() => LoginOrReg(
            isSignUp: false,
            authCtr: this,
          ));
    } else {
      showElegantNotif(
        context,
        title: 'Email not verified',
        description: 'Please open your mail and verify',
        elegantNotifType: NotificationType.error,
      );
    }
  }

  void loginWithEmail(
    BuildContext context,
  ) async {
    try {
      await firebaseAuth.signOut();
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailTxtCtr.text, password: passwordCtr.text);

      User? user = FirebaseAuth.instance.currentUser;

      if (!user!.emailVerified) {
        buttonStatus(
          buttonStatusType: ButtonState.error,
          buttonController: actionButtonController,
        );
        if (context.mounted) {
          showEmailNotVerirfiedPop(
            context,
            () {
              Navigator.of(context).pop();
              user.sendEmailVerification();
            },
          );
        }
      } else {
        buttonStatus(
          buttonStatusType: ButtonState.success,
          buttonController: actionButtonController,
        );

        delayedFunc(
          () {
            Get.offAllNamed(AppRoutes.bottomBar);
          },
        );
        //Add User FCBToken
      }
    } on FirebaseAuthException catch (e) {
      tezdaLog(e.code);
      buttonStatus(
        buttonStatusType: ButtonState.error,
        buttonController: actionButtonController,
      );
      if (context.mounted) firebaseErrorCode(context, e.code);
    } catch (e) {
      buttonStatus(
        buttonStatusType: ButtonState.error,
        buttonController: actionButtonController,
      );
      tezdaLog(e);
    }
  }

  void showEmailNotVerirfiedPop(
      BuildContext context, Function() onClickVerify) {
    showDialog(
      context: context,
      builder: (context) {
        return AccountInactiveDialog(onClickVerify: onClickVerify);
      },
    );
  }

  Future<void> logout() async {
    wantsToLogOut = true;
    StorageService.clearFavProducts();
    await firebaseAuth.signOut();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        googleBtnCtr.reset();
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(googleCredential);
        final User? user = userCredential.user;

        if (user != null) {
          googleLoginSuccess();
          // Successfully signed in
        }
      } on FirebaseAuthException catch (e) {
        buttonStatus(
            buttonStatusType: ButtonState.error,
            buttonController: googleBtnCtr);
        if (context.mounted) firebaseErrorCode(context, e.code);
      }
    } catch (e) {
      buttonStatus(
          buttonStatusType: ButtonState.error, buttonController: googleBtnCtr);
      tezdaLog(e);
    }
  }

  // Future<void> linkAccount(
  //     FirebaseAuthException e, AuthCredential googleCredential) async {
  //   final String email = e.email!;
  //   // final AuthCredential credential = AuthCredential(
  //   //   providerId: e.credential?.providerId ?? '',
  //   //   signInMethod: e.credential?.signInMethod ?? '',
  //   // );

  //   // Link Google credential to the existing email account
  //   final UserCredential emailUserCredential =
  //       await firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password:
  //         'user-provided-password', // Prompt user to provide their password here
  //   );

  //   final User? user = emailUserCredential.user;
  //   if (user != null) {
  //     await user.linkWithCredential(googleCredential);
  //     googleLoginSuccess();
  //   }
  // }

  void googleLoginSuccess() {
    buttonStatus(
      buttonStatusType: ButtonState.success,
      buttonController: googleBtnCtr,
    );

    delayedFunc(
      () {
        Get.offAllNamed(AppRoutes.bottomBar);
      },
    );
  }
}
