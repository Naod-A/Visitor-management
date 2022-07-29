// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:quiz_app/ui/Screens/CommonControllers/profile_controllers.dart';
import 'package:quiz_app/ui/Screens/Profile/widgets/user_profile_widget.dart';

import '../../utils/pallete.dart';

class UserDetailsScreen extends GetView<ProfileController> {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override

  //* User Info

  Widget build(BuildContext context) {
    // print(controller.userInfo.value!.gender);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile'.tr),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            profileCardContent(context),
            customText('first Name'.tr, 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(
                controller.firstName.value.toString(), true, false)),
            const SizedBox(height: 20),
            customText('last Name'.tr, 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(
                controller.lastName.value.toString(), true, false)),
            const SizedBox(height: 20),
            customText('email'.tr, 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(
                controller.userInfo.value!.email.toString(), true, false)),
            const SizedBox(height: 20),
            customText('password'.tr, 18, false, false, kblue),
            const SizedBox(height: 15),
            userInfoTiles(
                controller.userInfo.value!.password.toString(), true, true),
            const SizedBox(height: 20),
            customText('gender'.tr, 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(
                controller.gender.value ? 'Male'.tr : 'Female'.tr,
                true,
                false)),
            // userInfoTiles(Text('Esrom'), true),
          ],
        ),
      ),
      floatingActionButton: editIcon(context),
    );
  }
}
