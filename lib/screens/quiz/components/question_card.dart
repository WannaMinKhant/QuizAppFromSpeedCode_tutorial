import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:quizs_ui/controllers/quiz_controller.dart';
import 'package:quizs_ui/models/Question.dart';

import '../../../constants.dart';
import 'options.dart';

class QuestionsCard extends StatelessWidget {
  const QuestionsCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              question.question,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kBlackColor,
                  ),
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            ...List.generate(
              question.options.length,
              (index) => Options(
                text: question.options[index],
                index: index,
                press: () {
                  _controller.checkAns(question, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
