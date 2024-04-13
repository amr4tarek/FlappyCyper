import 'dart:async';

import 'package:flutter/material.dart';

class GameLogic {
  double carPosition = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;
  List<double> barrierX = [1, 2.5];
  int bestScore = 0;
  int initialScore = 0;

  Function(void Function())? setStateCallback;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = carPosition;
    });
  }

  void startGame(BuildContext context) {
    gameHasStarted = true;
    bool passedBarrierOne = false;
    bool passedBarrierTwo = false;
    int score = 0;

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        carPosition = initialHeight - height;
      });

      for (int i = 0; i < barrierX.length; i++) {
        if (barrierX[i] < -2) {
          barrierX[i] += 3.5;
          if (i == 0) passedBarrierOne = false;
          if (i == 1) passedBarrierTwo = false;
        } else {
          barrierX[i] -= 0.05;
          if (barrierX[i] < 0.2 && barrierX[i] > -0.2) {
            if (i == 0 && !passedBarrierOne) {
              score++;
              passedBarrierOne = true;
            }
            if (i == 1 && !passedBarrierTwo) {
              score++;
              passedBarrierTwo = true;
            }
          }
        }
      }

      if (score > bestScore) {
        setState(() {
          bestScore = score;
          initialScore = score;
        });
      }

      if (score > initialScore) {
        setState(() {
          initialScore = score;
        });
      }

      if (checkCollision()) {
        timer.cancel();
        showGameOverDialog(context);
      }
    });
  }

  bool checkCollision() {
    if (carPosition <= -1 || carPosition >= 1) {
      return true;
    }
    for (double x in barrierX) {
      if (x < 0.2 && x > -0.2) {
        if (carPosition < -0.7 && carPosition > -1.1) {
          return true;
        }
        if (carPosition > 0.7 && carPosition < 1.1) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Game Over',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Orbitron',
                      fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'You scored $initialScore points!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Roboto', fontSize: 18),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    setStateCallback!(() {
                      carPosition = 0;
                      time = 0;
                      height = 0;
                      initialHeight = 0;
                      barrierX = [1, 2.5];
                      initialScore = 0;
                      gameHasStarted = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF6C00FF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Restart',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setState(void Function() fn) {
    setStateCallback!(fn);
  }
}
