import 'package:calculator/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userQuestion = "";
  var userAnswer = "";
  var previousAnswer = "";
  final textStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  userQuestion,
                  style: textStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  userAnswer,
                  style: textStyle,
                ),
              )
            ],
          )),
          Expanded(
            flex: 2,
            child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, index) {
                      if (index == 0) {
                        //Clear button
                        return Button(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                            });
                          },
                          btText: buttons[index],
                          color: Colors.green,
                          txtColor: Colors.white,
                        );
                      } else if (index == 1) {
                        // Delete Button
                        return Button(
                          buttonTapped: () {
                            if (userQuestion.isNotEmpty) {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            }
                          },
                          btText: buttons[index],
                          color: Colors.red,
                          txtColor: Colors.white,
                        );
                      } else if (index == buttons.length - 1) {
                        // Equal Button
                        return Button(
                          buttonTapped: () {
                            setState(() {
                              equalOpperation();
                            });
                          },
                          btText: buttons[index],
                          color: Colors.deepPurple,
                          txtColor: Colors.white,
                        );
                      } else if (index == buttons.length - 2) {
                        // Answer Button
                        return Button(
                          buttonTapped: () {
                            answerOpperation();
                          },
                          btText: buttons[index],
                          color: Colors.deepPurple,
                          txtColor: Colors.white,
                        );
                      } else {
                        // Rest of The buttons
                        return Button(
                          buttonTapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          btText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          txtColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                        );
                      }
                    })),
          ),
        ],
      ),
    );
  }

  bool isOperator(String op) {
    if (op == "%" ||
        op == "/" ||
        op == "x" ||
        op == "+" ||
        op == "-" ||
        op == "=") {
      return true;
    } else {
      return false;
    }
  }

  void equalOpperation() {
    String question = userQuestion;
    question = question.replaceAll("x", "*");
    question = question.replaceAll("ANS", previousAnswer);
    Parser p = Parser();
    Expression exp = p.parse(question);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      userAnswer = eval.toString();
    });
  }

  void answerOpperation() {
    setState(() {
      previousAnswer = userAnswer;
      userQuestion = "ANS";
    });
  }
}
