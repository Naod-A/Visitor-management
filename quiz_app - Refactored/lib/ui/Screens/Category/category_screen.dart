import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:quiz_app/service/services.dart';
import 'package:quiz_app/ui/common_widgets/appbar.dart';
import 'package:quiz_app/ui/common_widgets/default_card.dart';
import 'package:quiz_app/ui/utils/theme.dart';

import '../../../routes/router.gr.dart';
// import '../Auth/Controllers/auth_controller.dart';
import 'package:quiz_app/ui/Screens/Profile/widgets/user_profile_widget.dart';

import '../CommonControllers/question_controller.dart';

// import '../CommonControllers/profile_controllers.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);

  // ProfileController pController = Get.put(ProfileController());
  final QuestionController questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    // print('from CHOOSE TYPE ${questionController.questionApi}');
    print('after logout email - category ${controller.userInfo.value!.email}');
    return SafeArea(
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: quizAppBar(context: context, iconUrl: ''),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text("Select Category".tr,
                      style: Theme.of(context).primaryTextTheme.headline1),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  ChoiceCard(
                    imgPosY: -130,
                    imgeSrc: "assets/icons/front end icons_small.svg",
                    cardtext: "Front-End",
                    onpressed: () async {
                      var course = await fetchCourses('Front-End'.tr);
                      context.router.push(LanguageChoices(courses: course));
                    },
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  ChoiceCard(
                    imgPosY: -130,
                    imgeSrc: "assets/icons/aws icons_small.svg",
                    cardtext: "Cloud-Service",
                    onpressed: () async {
                      var course = await fetchCourses('cloud_services'.tr);
                      context.router.push(LanguageChoices(courses: course));
                    },
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  ChoiceCard(
                    imgheig: 280,
                    imgPosY: -130,
                    imgeSrc: "assets/icons/logos_nodejs-icon_small.svg",
                    cardtext: "Back-End",
                    onpressed: () async {
                      var course = await fetchCourses('Back_end'.tr);
                      context.router.push(LanguageChoices(courses: course));
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
