import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_task/app_widgets/custom_image_view.dart';
import 'package:tezda_task/core/app_assets.dart';
import 'package:tezda_task/presentation/user/controller/user_controller.dart';
import 'package:tezda_task/presentation/user/widgets/user_container.dart';
import 'package:tezda_task/theme/app_style.dart';
import 'package:tezda_task/utils/app_colors.dart';
import 'package:tezda_task/utils/app_functions.dart';

class ProfileScreen extends StatelessWidget {
  final bool isFromAcc;
  final UserController userCtr;
  ProfileScreen({
    super.key,
    required this.isFromAcc,
    required this.userCtr,
  });

  late TextEditingController nameTxtCtr;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      initState: (state) {
        nameTxtCtr = TextEditingController(text: userCtr.user.displayName);
      },
      dispose: (state) {
        nameTxtCtr.dispose();
      },
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Profile',
              style: AppStyle.txtQuicksand,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                UserImageContainer(
                  userCtr: userCtr,
                  isFromAcc: isFromAcc,
                ),
                const Gap(40),
                profileTiles(
                  onTap: () {
                    nameTxtCtr =
                        TextEditingController(text: userCtr.user.displayName);

                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return EditNameTField(
                          nameTxtCtr: nameTxtCtr,
                          userCtr: userCtr,
                        );
                      },
                    );
                  },
                  title: 'Full Name',
                  isThreeLine: true,
                  subTiitle: userCtr.user.displayName!,
                  leading: CustomImageView(
                    svgPath: AppAssets.ASSETS_ICONS_USER_SVG,
                    color: AppColors.tabTextClr(),
                    height: 30,
                  ),
                ),
                const Gap(20),
                profileTiles(
                  leading: const Icon(Icons.email),
                  title: 'Email Address',
                  showEdit: false,
                  isThreeLine: false,
                  subTiitle: userCtr.user.email!,
                ),
                const Gap(20),
                profileTiles(
                  leading: const Icon(CupertinoIcons.time),
                  title: 'Created Since',
                  isThreeLine: false,
                  subTiitle: formatDate(userCtr.user.metadata.creationTime!),
                  showEdit: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile profileTiles({
    required String title,
    required String subTiitle,
    bool isThreeLine = false,
    required Widget leading,
    bool showEdit = true,
    Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      isThreeLine: isThreeLine,
      titleTextStyle: AppStyle.txtQuicksand.copyWith(
        fontWeight: FontWeight.w300,
        color: Colors.grey,
        fontSize: 13.0.dynFont,
      ),
      leading: Padding(
        padding: isThreeLine ? const EdgeInsets.only(top: 5) : EdgeInsets.zero,
        child: leading,
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTiitle,
            style: AppStyle.txtQuicksand.copyWith(fontWeight: FontWeight.w300),
          ),
          const Gap(7),
          if (isThreeLine)
            Text(
              'This name would be displayed to other users when you leave a review',
              style: AppStyle.txtQuicksand.copyWith(
                fontWeight: FontWeight.w300,
                color: Colors.grey,
                fontSize: 13.0.dynFont,
              ),
            ),
        ],
      ),
      trailing: showEdit
          ? Padding(
              padding:
                  isThreeLine ? const EdgeInsets.only(top: 5) : EdgeInsets.zero,
              child: Icon(
                Icons.edit_outlined,
                color: AppColors.lightBlue,
              ),
            )
          : null,
    );
  }
}

class EditNameTField extends StatefulWidget {
  const EditNameTField({
    super.key,
    required this.nameTxtCtr,
    required this.userCtr,
  });

  final TextEditingController nameTxtCtr;
  final UserController userCtr;

  @override
  State<EditNameTField> createState() => _EditNameTFieldState();
}

class _EditNameTFieldState extends State<EditNameTField> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter your name',
                style: AppStyle.txtQuicksand,
              ),
              TextFormField(
                onFieldSubmitted: (value) => changeName(),
                decoration: InputDecoration(
                  errorStyle: AppStyle.txtQuicksand.copyWith(fontSize: 13),
                ),
                style: AppStyle.txtQuicksand,
                controller: widget.nameTxtCtr,
                autofocus: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Name should not be empty';
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: AppStyle.txtQuicksand,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            changeName();
                          },
                          child: Text(
                            'Save',
                            style: AppStyle.txtQuicksand,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeName() {
    if (formKey.currentState!.validate()) {
      widget.userCtr.changeName(widget.nameTxtCtr.text);
    }
  }
}
