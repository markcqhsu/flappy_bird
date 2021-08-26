import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int curScore;
  const ScoreBoard({
    Key? key,
    required this.curScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/land.png"),
            fit: BoxFit.fitWidth,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                "分數",
                style: TextStyle(
                    fontSize: 24.0, color: Colors.white),
              ),
              Text(
                curScore.toString(),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "最高分",
                style: TextStyle(
                    fontSize: 24.0, color: Colors.white),
              ),
              Text(
                "128",
                style: TextStyle(
                    fontSize: 24.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}