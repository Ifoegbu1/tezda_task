import 'package:flutter/material.dart';
import 'package:tezda_task/utils/app_functions.dart';

class AppColors {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color lightBlue = fromHex('#7D99FB');
  static Color black = fromHex('#01030A');
  static Color lightGrey = fromHex('#ECF0FF');
  static const Color darkGrey = Color.fromRGBO(48, 48, 48, 1);

  static Color tabTextClr() {
    if (isDarkMode()) {
      return Colors.white;
    } else {
      return Colors.black87;
    }



  }

    static Color elegantNotifBgCLr() {
    if (isDarkMode()) {
      return Colors.grey.shade900;
    } else {
      return Colors.white;
    }
  }


  static Color homeItemBgClr() {
    if (isDarkMode()) {
      return AppColors.lightBlue.withOpacity(0.7);
    } else {
      return AppColors.lightGrey;
    }
  }

  static Color sizeBgClr() {
    if (isDarkMode()) {
      return Colors.black38;
    } else {
      return Colors.white;
    }
  }

  static Color sizeTxtClr() {
    if (isDarkMode()) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Color bottomBarbgClr() {
    if (isDarkMode()) {
      return Colors.black54;
    } else {
      return lightGrey.withOpacity(0.5);
    }
  }

  static Color bottomBarIconClr() {
    if (isDarkMode()) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
