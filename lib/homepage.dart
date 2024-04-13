import 'package:flappy_cyber/gameplay_area.dart';
import 'package:flappy_cyber/logic/game_logic.dart';
import 'package:flappy_cyber/score/score.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameLogic gameLogic = GameLogic();

  @override
  void initState() {
    super.initState();
    gameLogic.setStateCallback = setState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameLogic.gameHasStarted) {
          gameLogic.jump();
        } else {
          gameLogic.startGame(context);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            GamePlayArea(
                carPosition: gameLogic.carPosition,
                barrierXOne: gameLogic.barrierX[0],
                barrierXTwo: gameLogic.barrierX[1],
                gameHasStarted: gameLogic.gameHasStarted,
                initialScore: gameLogic.initialScore),
            ScoreBoard(),
            ScoreDisplay(
              initialScore: gameLogic.initialScore,
              bestScore: gameLogic.bestScore,
            ),
          ],
        ),
      ),
    );
  }
}
