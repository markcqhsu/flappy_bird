import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdY,
    this.onEnd,
  }) : super(key: key);

  final double birdY;
  final Function? onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      onEnd: () {
        onEnd?.call(); //?.call的意思是, 如果onEnd他是一個unDefind, 或是none就不執行後面的
      },
      alignment: Alignment(-0.8, birdY),
      child: Container(
          width: 40, height: 40, child: Image.asset("assets/images/logo.png")),
    );
  }
}