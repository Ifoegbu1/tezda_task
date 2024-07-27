import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tezda_task/presentation/auth/auth_controller.dart';
import 'package:tezda_task/presentation/home/controller/home_ctr.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';

class InitControllers extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<AuthController>(
      AuthController(
        firebaseAuth: FirebaseAuth.instance,
      ),
    );
    Get.put<UserController>(UserController());
  }
}
