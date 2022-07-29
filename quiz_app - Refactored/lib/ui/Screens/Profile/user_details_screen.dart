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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            profileCardContent(context),
            customText(context, 'First Name', 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(
                context, controller.firstName.value.toString(), true, false)),
            const SizedBox(height: 20),
            customText(context, 'Last Name', 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(
                context, controller.lastName.value.toString(), true, false)),
            const SizedBox(height: 20),
            customText(context, 'Email', 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(context,
                controller.userInfo.value!.email.toString(), true, false)),
            const SizedBox(height: 20),
            customText(context, 'Password', 18, false, false, kblue),
            const SizedBox(height: 15),
            userInfoTiles(context,
                controller.userInfo.value!.password.toString(), true, true),
            const SizedBox(height: 20),
            customText(context, 'Gender', 18, false, false, kblue),
            const SizedBox(height: 15),
            Obx(() => userInfoTiles(context,
                controller.gender.value ? 'Male' : 'Female', true, false)),
            // userInfoTiles(Text('Esrom'), true),
          ],
        ),
      ),
      floatingActionButton: editIcon(context),
    );
  }
}
