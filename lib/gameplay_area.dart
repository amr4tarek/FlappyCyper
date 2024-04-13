import 'package:flappy_cyber/barriers/barrirers.dart';
import 'package:flappy_cyber/car/car.dart';
import 'package:flutter/material.dart';

class GamePlayArea extends StatelessWidget {
  final double carPosition;
  final double barrierXOne;
  final double barrierXTwo;
  final bool gameHasStarted;
  final int initialScore;

  GamePlayArea({
    required this.carPosition,
    required this.barrierXOne,
    required this.barrierXTwo,
    required this.gameHasStarted,
    required this.initialScore,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          AnimatedContainer(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.fill,
              ),
            ),
            duration: const Duration(milliseconds: 0),
            alignment: Alignment(0, carPosition),
            child: MyCar(),
          ),
          Container(
            alignment: const Alignment(0, -0.3),
            child: gameHasStarted || initialScore > 0
                ? const Text('')
                : const Text(
                    'T A P  T O  P L A Y',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Orbitron'),
                  ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            alignment: Alignment(barrierXOne, 1.1),
            child: MyBarrier(
              size: 150.0,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            alignment: Alignment(barrierXOne, -1.1),
            child: MyBarrier(
              size: 200.0,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            alignment: Alignment(barrierXTwo, -1.1),
            child: MyBarrier(
              size: 250.0,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            alignment: Alignment(barrierXTwo, 1.1),
            child: MyBarrier(
              size: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
