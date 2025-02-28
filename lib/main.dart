import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Calc App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Calc App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color background = Color(0xFFD9D0DE);
  Color background2 = Color(0xFFBC8DA0);
  Color accent1 = Color(0xFFA04668);
  Color accent2 = Color.fromARGB(255, 100, 24, 60);
  Color text = Color(0xFF0C1713);
  Color text2 = Color.fromARGB(255, 250, 254, 252);
  String calculations = "";
  String error = "";

  List nums = ['9', '8', '7', '6', '5', '4', '3', '2', '1', '0'];

//this code deals with the first grid
  void _gridOneOperators(String op) {
    setState(() {
      //any numbers clicked are added to the calculation
      if (nums.contains(op)) {
         error = "";
        calculations += op;
      } else {
        switch (op) {
          //if clear is clicked,then clear the calculations bar
          case 'C':
            calculations = "";
            error = "";
            break;
            //if enter is clicked, then check edge cases before entering
          case '=':
            if (checkEnter()) {
              error = "";
              enter(calculations);
            }
            break;
        }
      }
    });
  }

//second grid deals with operators
  void _gridTwoOperators(String op) {
    setState(() {
      //check edge cases before adding operators
      if(check2()){
         error = "";
        calculations += " $op ";
      }
    });
  }

//checks edge cases for enter button
  bool checkEnter() {
    //check if the last char in calc is a number 
       if(calculations.isEmpty){
      error = "Nothing to calculate";
      return false;
    }

    if(nums.contains(getLastChar())){
      error = "";
      return true;
    }
    //else return false
    //error message: can't end equation with an operator
    error = "Can't end equation with an operator";
    return false;
  }

//checks edge cases
  bool check2 (){
    //if calculations is empty return false
    if (calculations.isEmpty){
      error = "Cannot start with an operator";
      return false;
    }


    //get last char in calculation
      
    //this will check if the last entered character is a number
    //if the last char is a number then return true
    if(nums.contains(getLastChar())){
      return true;
    }
    error = "Cannot place operator next to operator";
    return false;
  }

//enter button functionality
  void enter(String equation) {
    // Calculate and then return
    Parser parser = Parser();
    Expression expression = parser.parse(equation);
    double result = expression.evaluate(EvaluationType.REAL, ContextModel());
    error = "$result";
    calculations = "";
  }

//helper method to get last character in the calculation
  String getLastChar(){
    int calcLength = calculations.length;
    String lastNum = calculations.substring(calcLength - 1);
    return lastNum;
  }

  @override
  Widget build(BuildContext context) {
    List grid1 = ['9', '8', '7', '6', '5', '4', '3', '2', '1', 'C', '0', '='];
    List grid2 = ['+', '-', '*', '/'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background2,
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          fontFamily: 'BubbleFont', // Your custom font
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
      backgroundColor: background,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, // Align all children to the start
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First Expanded for Calculations + Error messages
          Expanded(
            flex: 1,
            child: Container(
              color: background2,
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    error,
                    style: TextStyle(fontSize: 40, color: text2),
                  ),
                  Container(
                    width: 450,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: accent1,width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  child: Text(
                    calculations,
                    style: TextStyle(fontSize: 30, color: text),
                  ),),
                  ],
                ),
                ),
              ),
            ),
          ),

          // for Numbers, Clear button, and Equal button
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 70.0,
              ), // Add vertical padding
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Center(
                  child: GridView.builder(
                    itemCount: grid1.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 8, // Space between rows
                      crossAxisSpacing: 8, // Space between cols
                    ),

                    itemBuilder: (context, index) {
                      return Container(
                        height: 5,
                        width: 5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent1,
                          ),
                          onPressed: () {
                            _gridOneOperators(grid1[index]);
                          },
                          child: Center(
                            child: Text(
                              grid1[index],
                              style: TextStyle(fontSize: 50, color: text),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          //Grid for operators 
          Container(
            height: 200, // Set the height as needed
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Center(
                child: GridView.builder(
                  itemCount: grid2.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    mainAxisSpacing: 8, // Space between rows
                    crossAxisSpacing: 8, // Space between cols
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 5,
                      width: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent2,
                        ),
                        onPressed: () {
                          _gridTwoOperators(grid2[index]);
                        },
                        child: Center(
                          child: Text(
                            grid2[index],
                            style: TextStyle(fontSize: 50, color: text2),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
