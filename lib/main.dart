import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flappy cap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, this.title = ""}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double birdY = 0;

  onJumpEnd(){
    setState(() {
      birdY = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            birdY -= 0.5;
          });
        },
        child: Bird(birdY: birdY, onEnd: onJumpEnd,),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdY, this.onEnd,
  }) : super(key: key);

  final double birdY;
  final Function? onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      onEnd: (){
        onEnd?.call();//?.call的意思是, 如果onEnd他是一個unDefind, 或是none就不執行後面的

      },
      alignment: Alignment(-0.8,birdY),
      child: Container(
          width: 40,
          height: 40,
          child: Image.asset("assets/images/logo.png")),
    );
  }
}
