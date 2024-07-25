import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/confirm_loading_button.dart';
import 'package:tezda_task/app_widgets/custom_text_field.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class LoginOrReg extends StatefulWidget {
  final AuthController authCtr;

  bool isSignUp;
  LoginOrReg({
    super.key,
    required this.authCtr,
    required this.isSignUp,
  });

  @override
  State<LoginOrReg> createState() => _LoginOrRegState();
}

class _LoginOrRegState extends State<LoginOrReg> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  void initState() {
    widget.authCtr.initCtr();
    super.initState();
  }

  @override
  void dispose() {
    widget.authCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    'Hello',
                    style: AppStyle.txtQuicksand
                        .copyWith(fontWeight: FontWeight.w900, fontSize: 47),
                  ),
                  Text(
                    widget.isSignUp
                        ? 'Sign up for your Tazda account'
                        : 'Sign into your account',
                    style: AppStyle.txtQuicksand
                        .copyWith(color: Colors.grey, fontSize: 25),
                  ),
                  const Gap(20),
                  if (widget.isSignUp)
                    CustomTextFormField(
                      controller: widget.authCtr.nameTxtCtr,
                      prefix: Icon(
                        Icons.person,
                        color: AppColors.lightBlue,
                      ),
                      margin: const EdgeInsets.only(top: 7),
                      width: 402,
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 30),
                      hintStyle: AppStyle.txtQuicksand,
                      height: 54,
                      hintText: 'Full Name',
                      radius: 20,
                      validator: (value) {
                        if (value!.isEmpty) return 'Required';
                        return null;
                      },
                      enabledBorderSide: BorderSide(
                        color: AppColors.fromHex('#243B4D'),
                      ),
                      borderSide:
                          BorderSide(color: AppColors.fromHex('#9AA5AD')),
                    ),
                  CustomTextFormField(
                    controller: widget.authCtr.emailTxtCtr,
                    prefix: Icon(
                      Icons.email,
                      color: AppColors.lightBlue,
                    ),
                    width: 402,
                    margin: const EdgeInsets.only(top: 20),
                    contentPadding: const EdgeInsets.only(top: 10, bottom: 30),
                    hintStyle: AppStyle.txtQuicksand,
                    height: 54,
                    hintText: 'Email',
                    radius: 20,
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';

                      if (!value.isEmail) return 'Please input a valid email';
                      return null;
                    },
                    enabledBorderSide: BorderSide(
                      color: AppColors.fromHex('#243B4D'),
                    ),
                    borderSide: BorderSide(color: AppColors.fromHex('#9AA5AD')),
                  ),
                  CustomTextFormField(
                    controller: widget.authCtr.passwordCtr,
                    isObscureText: !isPasswordVisible,
                    prefix: Icon(
                      Icons.password,
                      color: AppColors.lightBlue,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    width: 402,
                    contentPadding: const EdgeInsets.only(top: 10, bottom: 30),
                    hintStyle: AppStyle.txtQuicksand,
                    height: 54,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    hintText: 'Password',
                    radius: 20,
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';

                      if (widget.isSignUp && value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    enabledBorderSide: BorderSide(
                      color: AppColors.fromHex('#243B4D'),
                    ),
                    borderSide: BorderSide(color: AppColors.fromHex('#9AA5AD')),
                  ),
                  if (!widget.isSignUp)
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password',
                            style: AppStyle.txtQuicksand,
                          ),
                        )),
                  if (widget.isSignUp) const Gap(10),
                  ConfirmLoadingButton(
                    borderRadius: 20,
                    text: widget.isSignUp ? 'Sign Up' : 'Sign In',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.isSignUp) {
                          widget.authCtr.signUpWithEmail(context);
                        } else {
                          widget.authCtr.loginWithEmail(context);
                        }
                      } else {
                        actionButtonController.reset();
                      }
                    },
                  ),
                  // const Spacer(),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            style: AppStyle.txtQuicksand
                                .copyWith(color: Colors.grey),
                            children: [
                          TextSpan(
                            text: widget.isSignUp
                                ? 'Have an account already? '
                                : "Don't have an account? ",
                          ),
                          TextSpan(
                              text: widget.isSignUp ? 'Sign in' : 'Create',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (widget.isSignUp) {
                                    setState(() {
                                      widget.isSignUp = false;
                                    });
                                  } else {
                                    setState(() {
                                      widget.isSignUp = true;
                                    });
                                  }
                                  formKey.currentState!.reset();
                                },
                              style: AppStyle.txtQuicksand
                                  .copyWith(color: AppColors.lightBlue))
                        ])),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
