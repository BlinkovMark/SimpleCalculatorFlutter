import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: const Color.fromRGBO(0, 0, 0, 1.0),
    statusBarColor: Colors.transparent,
  ));
  runApp(const MaterialApp(home: Home()));
}

@override
void initState() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> buttons = [
    'C',
    '^',
    '%',
    'del',
    '7',
    '8',
    '9',
    '+',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '*',
    '0',
    '.',
    '=',
    '/',
  ];
  var userInput = '';
  var answer = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.black,
      child: Column(
            children: <Widget>[
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                      width: MediaQuery.of(context).size.width - 25,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Text(
                        userInput,
                        style: const TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      width: MediaQuery.of(context).size.width - 25,
                      height: MediaQuery.of(context).size.height / 4.8,
                      child: Text(
                        answer,
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 4,
            child:
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: List.generate(buttons.length, (index) {
                return FlatButton(
                  child: Text(
                    buttons[index],
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (buttons[index] == 'C') {
                        userInput = '';
                        answer = '0';
                      } else if (buttons[index] == '=') {
                        try {
                          Parser p = Parser();
                          Expression exp = p.parse(userInput);
                          ContextModel cm = ContextModel();
                          answer = '${exp.evaluate(EvaluationType.REAL, cm)}';
                          userInput = answer;
                        } catch (e) {
                          answer = 'Error';
                        }

                      } else if (buttons[index] == 'del') {
                        userInput = userInput.substring(0, userInput.length - 1);
                      } else if (buttons[index] == '^') {
                        userInput += '^';
                      } else if (buttons[index] == '%') {
                        userInput += '%';
                      } else {
                        userInput += buttons[index];
                      }
                    }
                    );
                  },
                );
              }),
            ),
          ),
        ],
      )
    ));
  }
}
