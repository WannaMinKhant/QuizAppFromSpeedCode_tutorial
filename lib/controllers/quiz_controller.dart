import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizs_ui/models/Question.dart';
import 'package:quizs_ui/screens/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;

  Animation get animation => this._animation;

  late PageController _pageController = PageController();

  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map((question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index'],
          ))
      .toList();

  List<Question> get question => this._questions;
  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;

  int _correctAns = 0;

  int get correctAns => this._correctAns;

  late int _selectedAns;

  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    // TODO: implement onInit

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    _animationController.forward().whenComplete(() => nextQuestion());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns)
      {
        _numOfCorrectAns++;
      }


    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });

  }

  void nextQuestion(){
    if(_questionNumber.value != question.length){
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      _animationController.reset();
      _animationController.forward().whenComplete(() => nextQuestion());
    }else{
      Get.to(() => ScoreScreen());
    }
  }

  void updateTheQnNum(int index){
    _questionNumber.value = index + 1;
  }
}
