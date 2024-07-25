import 'package:flutter/material.dart';
import 'package:tezda_task/utils/app_functions.dart';

class AppColors {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  static const Color darkBlue = Color.fromRGBO(36, 59, 77, 1.0);
  static Color lightBlue = fromHex('#7D99FB');
  static Color black = fromHex('#01030A');
  static Color lightGrey = fromHex('#ECF0FF');
  static const Color darkGrey = Color.fromRGBO(48, 48, 48, 1);

  static Color tabTextClr() {
    return isDarkMode() ? Colors.white : Colors.black87;
  }

  static Color elegantNotifBgClr() {
    return isDarkMode() ? Colors.grey.shade900 : Colors.white;
  }

  static Color homeItemBgClr() {
    return isDarkMode()
        ? AppColors.lightBlue.withOpacity(0.7)
        : AppColors.lightGrey;
  }

  static Color sizeBgClr() {
    return isDarkMode() ? Colors.black38 : Colors.white;
  }

  static Color sizeTxtClr() {
    return isDarkMode() ? Colors.white : Colors.black;
  }

  static Color bottomBarBgClr() {
    return isDarkMode() ? Colors.black54 : lightGrey.withOpacity(0.5);
  }

  static Color bottomBarIconClr() {
    return isDarkMode() ? Colors.white : Colors.black;
  }

  static Color? dialogBgClr() {
    return isDarkMode() ? null : Colors.white;
  }


  static Color? containerClr() {
        return isDarkMode() ? AppColors.darkBlue.withOpacity(0.1) : Colors.white;


  }
}

