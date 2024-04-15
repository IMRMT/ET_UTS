import 'dart:async';
import 'package:cardgame/screen/questionbank.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _QuizState();
}

class _QuizState extends State<Game> {

  List<QuestionObj> _questions = [];
  List<AnswerImage> _answerimg= [];
  int _question_no = 0;
  int _point=0;

  int _hitungGambar = 3;
  int _initialValueGambar = 3;

  int _hitung = 30;
  int _initialValue = 30;
  late Timer _timer;
  late Timer _timerGambar;
  // String _activeUser = "";
  
  @override
  void initState() {
    super.initState();

    _answerimg =[
      AnswerImage('assets/images/piring-1.jpeg'),
      AnswerImage('assets/images/sepeda-3.jpeg'),
      AnswerImage('assets/images/mobil-2.jpg'),
      AnswerImage('assets/images/motor-1.jpg'),
      AnswerImage('assets/images/rumah-1.jpg'),

    ];
    _questions =[
      QuestionObj("Which card have you seen before?", 'assets/images/piring-1.jpeg','assets/images/piring-2.jpeg', 
                  'assets/images/piring-3.jpeg', 'assets/images/piring-4.jpeg', 'assets/images/piring-1.jpeg'),

      QuestionObj("Which card have you seen before?", 'assets/images/sepeda-1.jpeg', 'assets/images/sepeda-2.jpeg',
                  'assets/images/sepeda-3.jpeg', 'assets/images/sepeda-4.jpeg', 'assets/images/sepeda-3.jpeg'),

      QuestionObj("Which card have you seen before?", 'assets/images/mobil-1.jpg','assets/images/mobil-2.jpg', 
                  'assets/images/mobil-3.jpg', 'assets/images/mobil-4.jpg', 'assets/images/mobil-2.jpg'),

      QuestionObj("Which card have you seen before?", 'assets/images/motor-1.jpg','assets/images/motor-2.jpeg', 
                  'assets/images/motor-3.jpg', 'assets/images/motor-4.jpg', 'assets/images/motor-1.jpg'),

      QuestionObj("Which card have you seen before?", 'assets/images/rumah-1.jpg','assets/images/rumah-2.jpg', 
                  'assets/images/rumah-3.jpg', 'assets/images/rumah-4.jpg', 'assets/images/rumah-1.jpg'),
    ];
    _questions.shuffle();

    timerMethod();

    // _getActiveUser();
  }

  // void _getActiveUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _activeUser = prefs.getString("user_id") ?? "";
  //   });
  // }

  //   void _saveTopScore() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final int? topPoint = prefs.getInt("top_point");
  //   if (topPoint == null || _point > topPoint) {
  //     prefs.setInt("top_point", _point);
  //     prefs.setString("top_user", _activeUser);
  //   }
  // }

  @override
  void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();

    _timerGambar.cancel();
    _hitungGambar = 0;
  }


  void timerMethod() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if(_hitung >0){
          _hitung--;
        } 
        else{
          // _timer.cancel();
          // _hitung =10;
          //   _question_no++;
          //   if (_question_no > _questions.length - 1) _question_no = 0;
          //   _hitung = _initialValue;
          finishQuiz();
        }
        // else if(_hitung == 0){
        //   	showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //     title: Text('Timer'),
        //     content: Text('Timer is up'),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'OK'),
        //         child: const Text('OK'),
        //     ),
        //     ],
        //     ));
        //   _timer.cancel();
        //   _hitung =10;
        // }

      });
    },);
  }

    void timerMethodGambar() {
    _timerGambar = Timer.periodic(Duration(milliseconds: 300), (timerGambar) {
      setState(() {
        if(_hitungGambar >0){
          _hitungGambar--;
        } 
        else{
          // _timer.cancel();
          // _hitung =10;
          //   _question_no++;
          //   if (_question_no > _questions.length - 1) _question_no = 0;
          //   _hitung = _initialValue;
          finishQuiz();
        }
        // else if(_hitung == 0){
        //   	showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //     title: Text('Timer'),
        //     content: Text('Timer is up'),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'OK'),
        //         child: const Text('OK'),
        //     ),
        //     ],
        //     ));
        //   _timer.cancel();
        //   _hitung =10;
        // }

      });
    },);
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
          child: Column(children: <Widget>[
        // Text(formatTime(_initialValue),
        //     style: const TextStyle(
        //       fontSize: 24,
        //     )),
            CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 20.0,
                percent: 1 - (_hitung / _initialValue),
                center: Text(formatTime(_hitung)),
                progressColor: Colors.red,
              ),
            ElevatedButton(onPressed: (){
              setState(() {
                 _timer.isActive? _timer.cancel():timerMethod();
              });
              // _timer.cancel();
            }, child: Text(_timer.isActive?"STOP":"START"),
            // child: Text("STOP")
            ),
            //  ElevatedButton(onPressed: (){
            //   timerMethod();
            // }, child: Text("START")),
            Divider(height: 10,),


            Divider(height: 10,),
            Text(_questions[_question_no].narration),
            TextButton(
                onPressed: () {
                  checkAnswer(_questions[_question_no].option_a);
                },
                child:             
                Image.asset(
              _questions[_question_no].option_a,
              height: 200,
              width: 200,

            ),),
            TextButton(
                onPressed: () {
                  checkAnswer(_questions[_question_no].option_b);
                },
                child:             Image.asset(
              _questions[_question_no].option_b,
              height: 200,
              width: 200,
            ),),
            TextButton(
                onPressed: () {
                  checkAnswer(_questions[_question_no].option_c);
                },
                child:             Image.asset(
              _questions[_question_no].option_c,
              height: 200,
              width: 200,
            ),),
            TextButton(
                onPressed: () {
                  checkAnswer(_questions[_question_no].option_d);
                },
                child:             Image.asset(
              _questions[_question_no].option_d,
              height: 200,
              width: 200,
            ),),
      ])),
    ));
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
      } 
      else if (_question_no == _questions.length){
        finishQuiz();
      }
      _hitung = _initialValue;
    });
  }

  startQuiz(){
    
  }

  finishQuiz(){
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
       Navigator.pop(context,);
      },
      child: const Text('OK'),
      ),
      ],
      ));
}
}