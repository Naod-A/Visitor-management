import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/profile_controllers.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/question_controller.dart';
import 'package:quiz_app/ui/common_widgets/appbar.dart';
import 'package:quiz_app/ui/common_widgets/circularScore.dart';
import 'package:quiz_app/ui/common_widgets/default_card.dart';
import 'package:quiz_app/ui/utils/theme.dart';

import '../../../routes/router.gr.dart';

class LanguageChoices extends StatelessWidget {
  LanguageChoices({Key? key, required this.courses}) : super(key: key);
  dynamic courses;
  QuestionControl qController = Get.put(QuestionControl());
  ProfileController pController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: quizAppBar(context:context, iconUrl: ''),
          body: Column(
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              Text("Select Language",
                  style: Theme.of(context).primaryTextTheme.headline1),
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: defaultPadding * 3),
                  itemCount: courses.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int percentage = 0;
                    if (pController.scores != null) {
                      for (var element in pController.scores!) {
                        if (courses[index]['courseName'] ==
                            element['courseName']) {
                          percentage = element['percentage'];
                          break;
                        }
                      }
                    }

                    return ChoiceCard(
                      child: CircularScore(
                        scorePercent: percentage,
                      ),
                      imgPosY: -100,
                      imgeSrc: courses[index]['icon'],
                      cardtext: courses[index]['courseName'],
                      onpressed: () {
                        qController.chosenCourse.value =
                            courses[index]['courseName'];
                        qController.chosenCourseType.value =
                            courses[index]['category'];
                        context.router.push(ChooseType(
                            icon: courses[index]['icon'],
                            path: courses[index]['courseName']));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: defaultPadding * 3,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
