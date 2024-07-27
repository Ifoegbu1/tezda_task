import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezda_task/core/app_const.dart';
import 'package:tezda_task/core/services/theme_service.dart';
import 'package:tezda_task/presentation/user/models/user_model.dart';
import 'package:tezda_task/utils/app_functions.dart';

class UserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel? userInfo;

  bool coolDown = false;
  bool isUploadStarted = false;

  // UserInfo get userInfo => user.providerData.length == 1
  //     ? user.providerData[0]
  //     : user.providerData
  //         .where(
  //           (element) => element.providerId == 'password',
  //         )
  //         .toList()[0];
  User get user => FirebaseAuth.instance.currentUser!;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> getUserInfo() async {
    await firestore
        .collection(AppConst.users)
        .doc(user.uid)
        .get()
        .then((value) {
      userInfo = UserModel.fromMap(value.data()!);
      update();
    });
  }

  Future<void> changeTheme(BuildContext context) async {
    if (isDarkMode()) {
      startCoolDownTimer();
      final themeSwitcher = ThemeSwitcher.of(context);
      const themeName = 'light';

      final service = await ThemeService.instance
        ..save(themeName);

      final theme = service.getByName(themeName);
      themeSwitcher.changeTheme(
        theme: theme,
      );
    } else {
      startCoolDownTimer();
      final themeSwitcher = ThemeSwitcher.of(context);
      const themeName = 'dark';

      final service = await ThemeService.instance
        ..save(themeName);
      final theme = service.getByName(themeName);

      themeSwitcher.changeTheme(theme: theme);
    }
  }

  Future<void> startCoolDownTimer() async {
    coolDown = true;

    await Future.delayed(
      900.milliseconds,
      () {
        coolDown = false;
      },
    );
    update();
  }

  Future<void> uploadImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      _image = File(pickedFile.path);
      isUploadStarted = true;
      update();
      String fileName = _image!.path.split('/').last;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('uploads/${userInfo!.uid}/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;
      tezdaLog('File uploaded successfully.');
      String downloadURL = await storageReference.getDownloadURL();
      userInfo?.photoURL = downloadURL;
      await updatePhotoURL(downloadURL);
      isUploadStarted = false;
      update();
    } catch (e) {
      isUploadStarted = false;
      update();
      tezdaLog('Error uploading image: $e');
    }
  }

  Future<void> changeName(String name) async {
    try {
      Get.back();
      await firestore
          .collection(AppConst.users)
          .doc(user.uid)
          .update({'displayName': name});
      await getUserInfo();
    } catch (e) {
      tezdaLog(e);
    }
  }

  Future<void> updatePhotoURL(String url) async {
    try {
      await firestore
          .collection(AppConst.users)
          .doc(user.uid)
          .update({'photoURL': url});

      getUserInfo();
    } catch (e) {
      tezdaLog(e);
    }
  }
}
