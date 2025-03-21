import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  _CalculatorState createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String result = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "0";
      } else if (value == "=") {
        try {
          input = "${_evaluateExpression(input)}";
          result = "";
        } catch (e) {
          result = "Error";
        }
      } else {
        input += value;
        result = " ${_evaluateExpression(input)}";
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(
            color: const Color.fromARGB(255, 225, 1, 255),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        // mainAxisSize: MainAxisSize.,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                input,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
                    
          SizedBox(height: 5),
          Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [
                      const Color.fromARGB(200, 0, 137, 248),
                      const Color.fromARGB(200, 216, 2, 253),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(thickness: 1, color: const Color.fromARGB(255, 225, 1, 255)),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children:
                [
                  "7",
                  "8",
                  "9",
                  "/",
                  "4",
                  "5",
                  "6",
                  "*",
                  "1",
                  "2",
                  "3",
                  "-",
                  "C",
                  "0",
                  "=",
                  "+",
                ].map((text) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 225, 1, 255),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                  
                    onPressed:
                        () => setState(() {
                          onButtonPressed(text);
                        }),
                    child: Text(
                      text,
                      style: TextStyle(
                        // backgroundColor: Colors.black,
                        // color: Colors.amber,
                        fontSize: 24,
                      ),
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

// class Calculator extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _Calculator();
//   }
// }

// class _Calculator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 400,
//       child: Row(
//         children: [
//           Column(
//             children: [ElevatedButton(onPressed: () {}, child: Text("1"))],
//           ),
//         ],
//       ),
//     );
//   }
// }
