import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/app_widgets/custom_photoview.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class UserImageContainer extends StatelessWidget {
  final UserController userCtr;
  final bool isFromAcc;

  const UserImageContainer({
    super.key,
    required this.userCtr,
    required this.isFromAcc,
  });

  @override
  Widget build(BuildContext context) {
    User user = userCtr.user;

    return Stack(
      fit: StackFit.passthrough,
      children: [
        SizedBox(
          height: 120.0.dynH,
          width: 140.0.dynW,
          child: Hero(
            tag: isFromAcc ? 'acct-pic' : 'profile-pic',
            child: FittedBox(
              child: CircleAvatar(
                // backgroundColor: AppColors.lightBlue,

                // backgroundImage: authCtr.isUploadStarted
                //     ? null
                //     : CachedNetworkImageProvider(
                //         user.profilePic!,
                //       ),
                backgroundColor: AppColors.lightBlue.withOpacity(0.5),
                child: userCtr.isUploadStarted
                    ? CupertinoActivityIndicator(
                        color: AppColors.lightGrey,
                      )
                    : CustomImageView(
                        isProfile: true,
                        fit: BoxFit.cover,
                        url: user.photoURL,
                        height: 120.0.dynH,
                        width: user.photoURL != null ? 140.0.dynW : 50,
                        radius: BorderRadius.circular(40),
                        onTap: () {
                          Get.to(
                            () => CustomPhotoView(
                              photoUrl: user.photoURL!,
                              heroTag: isFromAcc ? 'acct-pic' : 'profile-pic',
                            ),
                            transition: Transition.noTransition,
                          );
                        },
                      ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            highlightColor: AppColors.lightBlue.withOpacity(0.2),
            onPressed: () {
              userCtr.uploadImage();
            },
            icon: Icon(
              size: 40,
              CupertinoIcons.camera_circle_fill,
              color: AppColors.lightBlue,
            ),
          ),
        ),
      ],
    );
  }
}
