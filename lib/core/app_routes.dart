import 'package:get/get.dart';
import 'package:tezda_task/presentation/auth/auth_screen.dart';
import 'package:tezda_task/presentation/bottom_bar/bottom_bar.dart';
import 'package:tezda_task/presentation/splash/splash_screen.dart';

class AppRoutes {
  static const initialR = '/';
  static const bottomBar = '/bottom_bar';
  static const auth = '/auth';

  static List<GetPage> routes = [
    GetPage(
      name: bottomBar,
      page: () => const FluidBottomBar(),
      transition: Transition.fade,
      // transitionDuration: 500.milliseconds,
    ),
    GetPage(
      name: initialR,
      page: () => const SplasScreen(),
      transition: Transition.fade,
      // transitionDuration: 500.milliseconds,
    ),
    GetPage(
      name: auth,
      page: () =>  AuthScreen(),
      transition: Transition.fade,
      transitionDuration: 500.milliseconds,
    ),
  ];
}
