import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/service/api.dart';
//import 'package:quiz_app/service/model.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/profile_controllers.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/question_controller.dart';
import 'package:quiz_app/ui/Screens/Question/models/scores.dart';
import 'package:quiz_app/ui/Screens/Question/widgets/count_down.dart';
import 'package:quiz_app/ui/common_widgets/appbar.dart';
//import 'package:quiz_app/ui/common_widgets/appbar_evalu.dart';
import 'package:quiz_app/ui/utils/pallete.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../../common_widgets/alert_box.dart';
import '../../common_widgets/alert_box.dart';
import '../../common_widgets/score_alert_box.dart';
import '../Profile/widgets/user_profile_widget.dart';
import '/routes/router.gr.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuestionsScreen extends StatelessWidget {
  QuestionsScreen(
      {Key? key,
      required this.icon,
      required this.path,
      required this.isFinal,
      this.ptype,
      this.ftype})
      : super(key: key);
  dynamic icon;
  String path;
  bool isFinal;
  String? ptype;
  String? ftype;

  final QuestionControl controller = Get.put(QuestionControl());
  final ProfileController pcontroller = Get.put(ProfileController());

  // ask Asme
  // Future<bool> _onWillPop() async {
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    var isCorrect = false;
    var isSelected = false;
    controller.questionApi!.shuffle();
    controller.choices =
        List.filled(controller.questionApi!.length + 1, '', growable: true);
    controller.answers =
        List.filled(controller.questionApi!.length + 1, '', growable: true);

    return SafeArea(
      child: WillPopScope(
        onWillPop: isFinal
            ? () {
                return quizAlertBox(
                    context,
                    "navigate",
                    "",
                    "hello you can't back during exam starts",
                    path,
                    icon,
                    controller,
                    false,
                    true);
              }
            : null,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          appBar: quizAppBar(
            context: context,
            iconUrl: icon,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
            child: controller.questionApi!.isEmpty
                ? Center(
                    child: ScoreAlertBox(
                        title: 'No Questions Available',
                        text:
                            'Please practice or choose other languages to test on.'))
                // : Center(child: ScoreAlertBox(title: '', text: ''))
                : Column(
                    children: [
                      isFinal ? MyTimer() : Container(), //1
                      isFinal ? const Spacer() : Container(), //2
                      // Question Number
                      Obx(
                        () => Text(
                            controller.qnIndex.toString() +
                                '/' +
                                controller.questionApi!.length.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white)),
                      ),

                      SizedBox(height: 20),

                      // Questions
                      SizedBox(
                        height: 540.0,
                        child: PageView.builder(
                            itemCount: controller.questionApi!.length,
                            onPageChanged: (pageNumber) {
                              controller.qnIndex.value = pageNumber + 1;
                            },
                            itemBuilder: (context, snapshot) {
                              var options = controller.questionApi![snapshot]
                                  ['options'] as List;
                              controller.optionList = options.length;

                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 10, 0),
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                  color: const Color.fromARGB(176, 34, 34, 34),

                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(
                                      flex: 1,
                                    ),
                                    AutoSizeText(
                                      controller.questionApi![snapshot]
                                              ['question']
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white),
                                      maxLines: 3,
                                    ),
                                    const Spacer(
                                      flex: 2,
                                    ),
                                    Container(
                                      height: 400.0,
                                      child: ListView.builder(
                                        itemCount: options.length,
                                        itemBuilder: (context, index) =>
                                            ButtonBar(
                                          alignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Obx(
                                              () => Container(
                                                  width: 300,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: controller.groupValue[
                                                                    snapshot] ==
                                                                controller.value[
                                                                        snapshot]
                                                                    [index]
                                                            ? kblue
                                                            : const Color
                                                                    .fromARGB(
                                                                255,
                                                                117,
                                                                110,
                                                                110),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Obx(() {
                                                    return RadioListTile<int>(
                                                        activeColor: kblue,
                                                        title: Wrap(
                                                          children: [
                                                            AutoSizeText(
                                                              options[index]
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                              maxLines: 2,
                                                            ),
                                                            const Spacer(),
                                                          ],
                                                        ),
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .trailing,
                                                        groupValue: controller
                                                                .groupValue[
                                                            snapshot],
                                                        value: controller
                                                                .value[snapshot]
                                                            [index],
                                                        onChanged: (newValue) {
                                                          controller.groupValue[
                                                                  snapshot] =
                                                              newValue as int;

                                                          // add choices to list without replacing

                                                          controller.choices
                                                              .removeAt(
                                                                  controller
                                                                      .qnIndex
                                                                      .value);
                                                          controller.choices
                                                              .insert(
                                                                  controller
                                                                      .qnIndex
                                                                      .value,
                                                                  options[index]
                                                                      .toString());

                                                          // save the correct ansers for score

                                                          if (options[index]
                                                                  .toString() ==
                                                              controller
                                                                  .questionApi![
                                                                      snapshot]
                                                                      ['answer']
                                                                  .toString()) {
                                                            // add answer
                                                            controller.answers
                                                                .removeAt(
                                                                    controller
                                                                        .qnIndex
                                                                        .value);

                                                            controller.answers.insert(
                                                                controller
                                                                    .qnIndex
                                                                    .value,
                                                                options[index]
                                                                    .toString());
                                                          } else {
                                                            // remove answer
                                                            controller.answers
                                                                .removeAt(
                                                                    controller
                                                                        .qnIndex
                                                                        .value);
                                                            controller.answers
                                                                .insert(
                                                                    controller
                                                                        .qnIndex
                                                                        .value,
                                                                    '');
                                                          }

                                                          // log('choice ${controller.choices}');
                                                          // log('answers ${controller.answers}');
                                                          // log('answerFromApi ${controller.questionApi![snapshot]['answer']}');

                                                          // old code for adding score

                                                          // if (options[index]
                                                          //         .toString() ==
                                                          //     controller
                                                          //         .questionApi![
                                                          //             snapshot]
                                                          //             ['answer']
                                                          //         .toString()) {
                                                          //   controller
                                                          //       .scoreCounter++;
                                                          //   print(
                                                          //       '🥂 ${controller.scoreCounter}');
                                                          //   isCorrect = true;
                                                          //   isSelected = true;
                                                          // } else {
                                                          //   if (controller
                                                          //           .scoreCounter !=
                                                          //       0) {
                                                          //     controller
                                                          //         .scoreCounter--;
                                                          //     print(
                                                          //         '🥂 ${controller.scoreCounter}');
                                                          //   }
                                                          //   isCorrect = false;
                                                          //   isSelected = true;
                                                          // }
                                                          // updateJsonTime(
                                                          //   answer: options[index],
                                                          //   id: controller
                                                          //           .questionApi![
                                                          //       snapshot]['id'],
                                                          //   isCorrect: isCorrect,
                                                          //   isSelected: isSelected,
                                                          // );
                                                          // print(controller
                                                          //         .questionApi![
                                                          //     snapshot]['id']);
                                                        });
                                                  })),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //const Spacer(),
                      // Done button
                      Obx(
                        () => controller.questionApi!.length ==
                                controller.qnIndex.value
                            ? ElevatedButton(
                                onPressed: () async {
                                  controller.choices.removeWhere(
                                      (item) => [''].contains(item));
                                  controller.answers.removeWhere(
                                      (item) => [''].contains(item));

                                  // log('After removing  ${controller.choices}');
                                  // log('Choices  ${controller.choices.length}');
                                  // log('Answers  ${controller.answers.length}');
                                  // log('controller.questionApi!.length  ${controller.questionApi!.length}');
                                  if (controller.choices.length !=
                                      controller.questionApi!.length) {
                                    quizAlertBox(
                                        context,
                                        'Notice',
                                        "CONTINUE",
                                        'hello you have unanswered question . Do you want go back and check or continue to score page ?',
                                        path,
                                        icon,
                                        controller,
                                        false,
                                        false);
                                  }

                                  double scorePercent =
                                      (controller.answers.length /
                                          controller.questionApi!.length *
                                          100);
                                  print('THE USER PERCENTAGE IS $scorePercent');

                                  CourseScore score = CourseScore(
                                      courseId: pController.userInfo.value!.id
                                              .toString() +
                                          controller.chosenCourse.value,
                                      courseName: controller.chosenCourse.value,
                                      courseType:
                                          controller.chosenCourseType.value,
                                      courseScore: controller.answers.length,
                                      coursePercentage: scorePercent,
                                      userId: pController.userInfo.value!.id);
                                  controller.isFinished = true;

                                  String checkid = pcontroller
                                          .userInfo.value!.id
                                          .toString() +
                                      controller.chosenCourse.value;
                                  if (isFinal) {
                                    if (score.courseId == checkid) {
                                      createUserScore(score);
                                    } else {
                                      saveUserScore(score);
                                    }
                                    print('data ${score.courseId}');
                                    controller.isEnabled.value = false;
                                  }

                                  if (controller.choices.length ==
                                      controller.questionApi!.length) {
                                    context.router.push(FinalScore(
                                        outOf: controller.questionApi!.length,
                                        score: controller.answers.length,
                                        optionList: controller.optionList));
                                    controller.qnIndex.value = 1;
                                    controller.scoreCounter = 0;
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(300, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    primary:
                                        const Color.fromARGB(255, 255, 165, 0)),
                                child: customText(
                                    'DONE', 20, false, false, primaryColor),
                              )

                            // ? const RoundedButton(
                            //     buttonName: 'Done',
                            //     page: '/finalScore',
                            //   )
                            : Container(),
                      ),
                      Spacer(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
