import 'dart:async';

import 'package:flappybird/pipe.dart';
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
  double pipeTwoX = 2.0;
  int score = 0;
  late Timer timer;
  // bool isCrash = false;


  bool checkCrash(double center, pipeX){
    if( pipeX <= -0.75 ){
      if((birdY > center + 0.25) || (birdY < center - 0.25)){
        return true;
      }
    }
    return false;
  }


  onJumpEnd() {
    setState(() {
      birdY = 1;
    });

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      final double newPipeOneX = pipeOneX - 0.02;
      final double newPipeTwoX = pipeTwoX - 0.02;
      bool isCrash = false;

      isCrash = checkCrash(gapOneCenter, pipeOneX);
      isCrash |= checkCrash(gapTwoCenter, pipeTwoX);

      if(pipeOneX < -0.8 || pipeTwoX < -0.8){
        setState(() {
          score += 1;
        });
      }

      if(isCrash == true){
        setState(() {
          isRunning = false;
          pipeOneX = 0.9;
          pipeTwoX = 1.4;
          birdY = 0;
        });

        timer.cancel();

      }else{
        setState(() {
          pipeOneX = newPipeOneX < -1 ? 1.1 : newPipeOneX;
          pipeTwoX = newPipeTwoX < -1 ? 1.1 : newPipeTwoX;
        });
      }

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
        child: Stack(
              children: [
                Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Stack(children: [
                            Pipe(pipeX: pipeOneX, pipeY: -1, pipeSize: maxHeight * (gapOneCenter - 0.25 + 1)/2 ),
                            Pipe(pipeX: pipeOneX, pipeY: 1, pipeSize: maxHeight *(1- (gapOneCenter + 0.25))/2),
                            Pipe(pipeX: pipeTwoX, pipeY: -1, pipeSize: maxHeight * (gapTwoCenter - 0.25 + 1)/2),
                            Pipe(pipeX: pipeTwoX, pipeY: 1, pipeSize: maxHeight *(1-(gapTwoCenter + 0.25))/2),
                            Bird(birdY: birdY, onEnd: onJumpEnd),
                          ])),
                      Expanded(
                        flex: 1,
                        child: ScoreBoard(curScore: score,),
                      ),
                    ],
                  ),
                if(isRunning == false)
                  GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: StartScreen(),
                  ),
              ],
            )
      ),
      backgroundColor: Colors.white,
    );
  }
}

