import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/core/app_routes.dart';
import 'package:tezda_task/theme/app_style.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    Future.delayed(
      2.seconds,
      () => checkIfUserLoggedIn(),
    );
    super.initState();
  }

  void checkIfUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAllNamed(AppRoutes.bottomBar);
    } else {
      Get.offAllNamed(AppRoutes.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'TEZDA TASK',
          style: AppStyle.txtQuicksand.copyWith(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
