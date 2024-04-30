import 'dart:async';
import 'package:cardgame/screen/questionbank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _QuizState();
}

class _QuizState extends State<Game> {

  bool animated = false;
  List<QuestionObj> _questions = [];
  List<AnswerImage> _answerimg = []; //gambar jawaban awal

  int _question_no = 0;
  int _img_no = 0;
  int _point = 0;

  int _hitungGambar = 3; //durasi gambar jawaban
  int _initialValueGambar = 3; 

  int _hitung = 30;//durasi pertanyaan
  int _initialValue = 30; 
  late Timer _timer;
  late Timer _timerGambar;
  // String _activeUser = "";

  late bool _timer2IsActive = false;

  @override
  void initState() {
    super.initState();

    _answerimg = [
      AnswerImage('assets/images/piring-1.jpeg'),
      AnswerImage('assets/images/sepeda-3.jpeg'),
      AnswerImage('assets/images/mobil-2.jpg'),
      AnswerImage('assets/images/motor-1.jpg'),
      AnswerImage('assets/images/rumah-1.jpg'),
    ];
    _questions = [
      QuestionObj(
          "Which card have you seen before?",
          'assets/images/piring-1.jpeg',
          'assets/images/piring-2.jpeg',
          'assets/images/piring-3.jpeg',
          'assets/images/piring-4.jpeg',
          'assets/images/piring-1.jpeg'),
      QuestionObj(
          "Which card have you seen before?",
          'assets/images/sepeda-1.jpeg',
          'assets/images/sepeda-2.jpeg',
          'assets/images/sepeda-3.jpeg',
          'assets/images/sepeda-4.jpeg',
          'assets/images/sepeda-3.jpeg'),
      QuestionObj(
          "Which card have you seen before?",
          'assets/images/mobil-1.jpg',
          'assets/images/mobil-2.jpg',
          'assets/images/mobil-3.jpg',
          'assets/images/mobil-4.jpg',
          'assets/images/mobil-2.jpg'),
      QuestionObj(
          "Which card have you seen before?",
          'assets/images/motor-1.jpg',
          'assets/images/motor-2.jpeg',
          'assets/images/motor-3.jpg',
          'assets/images/motor-4.jpg',
          'assets/images/motor-1.jpg'),
      QuestionObj(
          "Which card have you seen before?",
          'assets/images/rumah-1.jpg',
          'assets/images/rumah-2.jpg',
          'assets/images/rumah-3.jpg',
          'assets/images/rumah-4.jpg',
          'assets/images/rumah-1.jpg'),
    ];
    _questions.shuffle();

    timerMethod();
  }



  @override
  void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  void timerMethod() {
    _timer = Timer.periodic(
      Duration(milliseconds: 1000),
      (timer) {
        setState(() {
          animated = !animated;
          if (_hitung > 0) {
            _hitung--;

          } else {
              if (!_timer2IsActive) {
                _timer.cancel();
                timerMethodGambar();
            }
          }
        });
      },
    );
  }

  //CEK ULANG
  void timerMethodGambar() {
    _timerGambar = Timer.periodic(
      Duration(milliseconds: 1000),
      (timerGambar) {
        setState(() {
          animated = !animated;
          if (_hitungGambar > 0) {
            _hitungGambar--;
          } else {
            _timerGambar.cancel();
            setState(() {
              animated = !animated;
              _hitungGambar = _initialValueGambar;
              _timer2IsActive = false;
            });
          }
        });
      },
    );
  }

  Widget widget2() {
    return Column(
      children: <Widget>[
        CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 20.0,
          percent: 1 - (_hitung / _initialValue),
          center: Text(formatTime(_hitung)),
          progressColor: Colors.red,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _timer.isActive ? _timer.cancel() : timerMethod();
            });
          },
          child: Text(_timer.isActive ? "STOP" : "START"),
        ),
        Divider(
          height: 10,
        ),
        Text(_questions[_question_no].narration),
        TextButton(
          onPressed: () {
            checkAnswer(_questions[_question_no].option_a);
          },
          child: Image.asset(
            _questions[_question_no].option_a,
            height: 200,
            width: 200,
          ),
        ),
        TextButton(
          onPressed: () {
            checkAnswer(_questions[_question_no].option_b);
          },
          child: Image.asset(
            _questions[_question_no].option_b,
            height: 200,
            width: 200,
          ),
        ),
        TextButton(
          onPressed: () {
            checkAnswer(_questions[_question_no].option_c);
          },
          child: Image.asset(
            _questions[_question_no].option_c,
            height: 200,
            width: 200,
          ),
        ),
        TextButton(
          onPressed: () {
            checkAnswer(_questions[_question_no].option_d);
          },
          child: Image.asset(
            _questions[_question_no].option_d,
            height: 200,
            width: 200,
          ),
        ),
      ],
    );
  }

  //CEK ULANG
  //Gambar jawaban
  Widget widget1(){
    return Column(
      children: <Widget>[
        CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 20.0,
          percent: 1 - (_hitungGambar / _initialValueGambar),
          center: Text(formatTime(_hitungGambar)),
          progressColor: Colors.red,
        ),
        Image.asset(
          _answerimg[_img_no].answer,
            height: 200,
            width: 200,
        ),
      ],
    );
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Quiz'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: SingleChildScrollView(
      child: Center(
        child: 
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(turns: animation, child: child);
            //return ScaleTransition(child: child, scale: animation);
          },
          child: animated ? widget1() : widget2(),
        ),
      ),
    ),
  );
}


  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 100;
      }
      _question_no++;
      if (_question_no > _questions.length) {
        _question_no = 0;
      } else if (_question_no == _questions.length) {
        finishQuiz();
      }
      _hitung = _initialValue;
    });
  }

  //CEK ULANG
  // startImage() {
  //   _timerGambar.cancel();
  // }


  finishQuiz() {
    _timer.cancel();
    _question_no = 0;
    // _saveTopScore();

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Quiz'),
              content: Text('Your point = $_point'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }
}
