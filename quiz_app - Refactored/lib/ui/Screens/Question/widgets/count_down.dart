import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:quiz_app/service/services.dart';
//import 'package:quiz_app/service/model.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/profile_controllers.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/question_controller.dart';
import 'package:quiz_app/ui/Screens/Question/models/scores.dart';

import '../../../../routes/router.gr.dart';

class MyTimer extends StatelessWidget {
  QuestionController controller = Get.put(QuestionController());
  ProfileController pcontroller = Get.put(ProfileController());
  dynamic icon;
  @override
  Widget build(BuildContext context) {
    Spacer();

    return Obx(
      () => TimerCountdown(
        format: CountDownTimerFormat.hoursMinutesSeconds,
        endTime: DateTime.now().add(
          Duration(
            hours: controller.hour.value,
            minutes: controller.minutes.value,
            seconds: controller.seconds.value,
          ),
        ),
        onEnd: () async {
          if (controller.isFinished) {
            log('Timer is done and doing nothing ');
          } else {
            // remove empty choices and answers
            controller.choices.removeWhere((item) => [''].contains(item));
            controller.answers.removeWhere((item) => [''].contains(item));

            if (controller.choices.every((element) => element == '') ||
                controller.answers.every((element) => element == '')) {
              controller.choices.clear();
              controller.answers.clear();
            }

            // check id
            String checkid = pcontroller.userInfo.value!.id.toString() +
                controller.chosenCourse.value;

            // get percentge
            double scorePercent = (controller.answers.length /
                controller.questionApi!.length *
                100);
            print('user percentage by timer $scorePercent');

            // change timer
            controller.seconds.value = 0;
            controller.isEnabled.value = false;

            // get score
            CourseScore score = CourseScore(
                courseId: pcontroller.userInfo.value!.id.toString() +
                    controller.chosenCourse.value,
                courseName: controller.chosenCourse.value,
                courseType: controller.chosenCourseType.value,
                courseScore: controller.answers.length,
                coursePercentage: scorePercent,
                userId: pcontroller.userInfo.value!.id);
            controller.isFinished = true;

            if (score.courseId == checkid) {
              saveUserScore(score);
            } else {
              createUserScore(score);
            }
            context.router.push(FinalScore(
              outOf: controller.questionApi!.length,
              score: controller.answers.length,
              optionList: controller.questionApi!.length,
            ));
            controller.qnIndex.value = 1;
            controller.scoreCounter = 0;

            print("Timer finished");
          }
        },
      ),
    );
  }
}
