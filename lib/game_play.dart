import 'package:flappybird_01/score.dart';
import 'package:flappybird_01/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'barrier.dart';
import 'bird.dart';
import 'bloc.dart';

class Game extends StatelessWidget {
  static late GameBloc _bloc;

  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc()..add(OnInitialiseGame()),
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameProgressUpdated) {
            if (state.birdYaxis > 1 || state.isBarrierTouched) {
              showGameOverDialog(context);
              return;
            }
          }
        },
        builder: (context, state) {
          _bloc = BlocProvider.of<GameBloc>(context);
          if (state is GameProgressUpdated) {
            final birdYaxis = state.birdYaxis;
            final barrierXOne = state.barrierXOne;
            final isStartGame = state.isStartGame;
            final barrierXTwo = state.barrierXTwo;
            final score = state.score;
            final bestScore = state.bestScore;
            return GestureDetector(
              onTap: () {
                isStartGame
                    ? _bloc.add(OnScreenTapped())
                    : _bloc.add(OnStartGame());
              },
              child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          MyBird(
                            birdYAxis: birdYaxis,
                          ),
                          // barrierXOne
                          MyBarrier(
                            barrierHeight: 180,
                            barrierXAxis: barrierXOne,
                            barrierYAxis: 1.1,
                          ),
                          //barrierXTwo
                          MyBarrier(
                            barrierHeight: 120,
                            barrierXAxis: barrierXTwo,
                            barrierYAxis: 1.1,
                          ),
                          //barrierXTwo
                          MyBarrier(
                            barrierHeight: 250,
                            barrierXAxis: barrierXTwo,
                            barrierYAxis: -1.1,
                          ),
                          //barrierXOne
                          MyBarrier(
                            barrierHeight: 180,
                            barrierXAxis: barrierXOne,
                            barrierYAxis: -1.1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 25),
                            decoration:
                                const BoxDecoration(color: Colors.brown),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ScoreTexts(
                                  title: "SCORE",
                                  subTitle: score.toString(),
                                ),
                                ScoreTexts(
                                  title: "BESTSCORE",
                                  subTitle: bestScore.toString(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 20,
                            color: Colors.green,
                          ),
                          const Align(
                            alignment: Alignment(0, 0.8),
                            child: Text(
                              "F L A P P Y   B I R D",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            visible: !isStartGame,
                            child: const Align(
                              alignment: Alignment(0, -0.975),
                              child: Text(
                                "T A B  T O  P L A Y",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SplashScreen();
        },
      ),
    );
  }

  showGameOverDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 222, 217, 148),
        title: const Image(
          image: AssetImage("images/bird.gif"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _bloc.add(OnStartGame());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 251, 161, 81)), //Background Color
              elevation: MaterialStateProperty.all(3), //Defines Elevation
              shadowColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 251, 161, 81)), //Defines shadowColor
            ),
            child: const Align(
              alignment: Alignment(0, 0),
              child: Text(
                "P L A Y  A G A I N",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
