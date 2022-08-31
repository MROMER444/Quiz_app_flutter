import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Questions.dart';


QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> ScoreKipper = [];

  void checkAnswer(bool user_answer) {
    bool correctAnswear = quizBrain.getCorrectAnswear();
    if (user_answer == correctAnswear) {
      print('user got it right!');
      ScoreKipper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      print('user got it wrong');
      ScoreKipper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }


    if(quizBrain.questions_number == 12){
      ScoreKipper.clear();
      quizBrain.res();
      Alert(context: context, title: "Finshed", desc: "Rate us!.").show();

    }



    setState(() {
      quizBrain.nextQuestion();
    });
  }

  // List <String> questions = [
  //       'You can lead a cow down stairs but not up stairs.',
  //       'Approximately one quarter of human bones are in the feet.',
  //       'A slug\'s blood is green.'
  // ];
  //
  // List <bool> answears = [false, true, true];
  //
  // Questions q1 = Questions(q: 'You can lead a cow down stairs but not up stairs.',a: false);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: ScoreKipper,
        )
      ],
    );
  }
}

