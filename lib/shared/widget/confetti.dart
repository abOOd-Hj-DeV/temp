import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CustomConfetti extends StatelessWidget {
  const CustomConfetti({
    super.key,
    required ConfettiController controllerCenter,
  }) : _controllerCenter = controllerCenter;

  final ConfettiController _controllerCenter;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controllerCenter,
      blastDirection: pi / 2, // Straight down
      emissionFrequency: 0.2,
      numberOfParticles: 150,
      maxBlastForce: 20,
      minBlastForce: 5,
      gravity: 0.2,
      minimumSize: const Size(5, 12),
      maximumSize: const Size(10, 25),
      colors: const [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
      ],
    );
  }
}
