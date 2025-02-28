import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background2,
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          fontFamily: 'BubbleFont', // Your custom font
          fontSize: 30,
          color: text,
        ),
      ),
      backgroundColor: background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align all children to the start
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First Expanded for 'Calculations'
          Expanded(
            flex: 1,
            child: Container(
              color: background2,
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Calculations',
                    style: TextStyle(fontSize: 30, color: text),
                  ),
                ),
              ),
            ),
          ),
          
          // Second Expanded for grid buttons with Padding
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Add vertical padding
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Center(
                  child: GridView.builder(
                    itemCount: 12,
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
                            primary: accent1,
                          ),
                          onPressed: () {},
                          child: Text(
                            '#',
                            style: TextStyle(fontSize: 30, color: text),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          
          // Third GridView at the bottom
          Container(
            height: 200, // Set the height as needed
            width: double.infinity,
            child: Center(
              child: GridView.builder(
                itemCount: 4,
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
                      onPressed: () {},
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 30, color: text),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
