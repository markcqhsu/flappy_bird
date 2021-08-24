import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0.2),
      child: Text(
        "點擊開始遊戲",
        style: TextStyle(fontSize: 48.0, color: Colors.green),
      ),
    );
  }
}

