import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tezda_task/app_widgets/loading_button.dart';
import 'package:tezda_task/core/services/storage_service.dart';

LoadingButtonController actionButtonController = LoadingButtonController();
LoadingButtonController googleBtnCtr = LoadingButtonController();

void tezdaLog(dynamic msg) {
  log(
    msg.toString(),
  );
}

extension SizeExtension on double {
  // double dynV() => (h - 72);
  double get dynH => h;
  double get dynW => w;

  double get dynFont => sp;
}

String getFirstWord(String input) {
  // Split the input string into words
  List<String> words = input.split(' ');

  // Check if there is at least one word
  if (words.isNotEmpty) {
    String firstWord = words.first.split("'")[0].capitalize!;

    // Return the first word
    return firstWord;
  } else {
    return "";
  }
}

buttonStatus({
  required ButtonState buttonStatusType,
  LoadingButtonController? buttonController,
}) async {
  buttonController ??= actionButtonController;

  buttonStatusType == ButtonState.error
      ? buttonController.error()
      : buttonController.success();

  Future.delayed(
    const Duration(seconds: 1),
    () => buttonController!.reset(),
  );
}

Future<void> delayedFunc(
  Function() func, [
  Duration duration = const Duration(seconds: 1),
]) async {
  await Future.delayed(
    duration,
    func,
  );
}

bool isDarkMode() {
  String? themeName = StorageService.prefs.getString('theme');

  bool isDarkMode = themeName == 'dark';
  // Get.appUpdate();
  return isDarkMode;
}

String formatDate(DateTime dateTime) {
  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  // Add the suffix (st, nd, rd, th) to the day
  String day = DateFormat("d").format(dateTime);
  String dayWithSuffix = day + getDaySuffix(int.parse(day));

  // Combine day with suffix and month, year
  return "$dayWithSuffix of ${DateFormat("MMMM").format(dateTime)}, ${DateFormat("yyyy").format(dateTime)}";
}

List<BoxShadow> containerElevation() {
  return [
    BoxShadow(
      color: Colors.white30.withOpacity(0.1),
      blurRadius: 6.0,
      offset: const Offset(
        5,
        5,
      ),
    ),
  ];
}
