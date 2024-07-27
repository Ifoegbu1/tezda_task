import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/theme/app_style.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  final authCtr = Get.find<AuthController>();
  @override
  void initState() {
    Future.delayed(
      2.seconds,
      () => authCtr.checkIfUserLoggedIn(),
    );
    super.initState();
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
