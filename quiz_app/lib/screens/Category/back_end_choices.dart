import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/router.gr.dart';
import '../../widgets/theme.dart';
import '../../widgets/common_components/appbar.dart';
import '../../widgets/common_components/default_card.dart';
import '../../Models/courses.dart';

class BackendChoices extends StatelessWidget {
  const BackendChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: quizeAppbar(context),
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
                  itemCount: backCourse.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChoiceCard(
                        imgPosY: -110,
                        imgeSrc: backCourse[index].icon!,
                        cardtext: backCourse[index].courseName,
                        onpressed: () {
                          context.router
                              .push(ChooseType(icon: backCourse[index].icon));
                        });
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