import 'package:flappybird/score_board.dart';
import 'package:flappybird/start.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

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

const double gapSize = 0.5;

class _MyHomePageState extends State<MyHomePage> {
  double birdY = 0;
  bool isRunning = false;
  double pipeSize = 300;
  double pipeOneX = 0.9;
  double gapOneCenter = 0.2;
  double gapTwoCenter = 0;
  double pipeTwoX = 0.3;
  // double pipeY = -1;

  onJumpEnd() {
    setState(() {
      birdY = 1;
    });
  }

  startGame() {
    setState(() {
      isRunning = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final maxHeight = MediaQuery.of(context).size.height * 3 /4;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            birdY -= 0.5;
          });
        },
        child: isRunning
            ? Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Stack(children: [
                        Pipe(pipeX: pipeOneX, pipeY: -1, pipeSize: maxHeight * (gapOneCenter - 0.25 + 1)/2 ),
                        Pipe(pipeX: pipeOneX, pipeY: 1, pipeSize: maxHeight *(1-(gapOneCenter + 0.25))/2),
                        Pipe(pipeX: pipeTwoX, pipeY: -1, pipeSize: maxHeight * (gapTwoCenter - 0.25 + 1)/2),
                        Pipe(pipeX: pipeTwoX, pipeY: 1, pipeSize: maxHeight *(1-(gapOneCenter + 0.25))/2),
                        Bird(birdY: birdY, onEnd: onJumpEnd),
                      ])),
                  Expanded(
                    flex: 1,
                    child: ScoreBoard(),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  startGame();
                },
                child: StartScreen(),
              ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class Pipe extends StatelessWidget {
  const Pipe({
    Key? key,
    required this.pipeX,
    required this.pipeY,
    required this.pipeSize,
  }) : super(key: key);

  final double pipeX;
  final double pipeY;
  final double pipeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(pipeX, pipeY),
      child: Container(
        width: 60,
        height: pipeSize,
        color: Colors.green,
      ),
    );
  }
}
