import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdYAxis;
  static const double birdXAxis = -0.5;
  MyBird({required this.birdYAxis});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      alignment: Alignment(birdXAxis, birdYAxis),
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Container(
        height: 75,
        width: 75,
        child: Image.asset('images/bird.gif'),
      ),
    );
  }
}
