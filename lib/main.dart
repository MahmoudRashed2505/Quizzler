import 'package:flutter/material.dart';
import 'package:quzzlier/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quzzlier());
}

class Quzzlier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quizzler",
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MainScreen(),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Icon> score = [];
  QuizBrain quizBrain = QuizBrain();

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
                quizBrain.questionBank[quizBrain.questionIndex].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
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
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                bool correctAnswer = quizBrain
                    .questionBank[quizBrain.questionIndex].questionAnswer;
                if (correctAnswer == true) {
                  print("user got it right");
                } else {
                  print('user got it wrong');
                }
                setState(() {
                  if (correctAnswer == true) {
                    score.add(Icon(
                      Icons.check,
                      color: Colors.green,
                    ));
                  } else {
                    score.add(Icon(
                      Icons.close,
                      color: Colors.red,
                    ));
                  }
                  if (!quizBrain.nextQuestion()) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "End Of Quizzlet",
                      desc: "You Reached the End of The Quiz",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              quizBrain.questionIndex = 0;
                              Navigator.pop(context);
                            });
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                    score.clear();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                bool correctAnswer = quizBrain
                    .questionBank[quizBrain.questionIndex].questionAnswer;

                setState(() {
                  if (correctAnswer == false) {
                    score.add(Icon(
                      Icons.check,
                      color: Colors.green,
                    ));
                  } else {
                    score.add(Icon(
                      Icons.close,
                      color: Colors.red,
                    ));
                  }
                  if (!quizBrain.nextQuestion()) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "End Of Quizzlet",
                      desc: "You Reached the End of The Quiz",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              quizBrain.questionIndex = 0;
                              Navigator.pop(context);
                            });
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                    score.clear();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}
