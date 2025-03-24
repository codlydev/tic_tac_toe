import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class TicTacToeBoard extends StatefulWidget {
  final bool isTwoPlayer;
  const TicTacToeBoard({Key? key, required this.isTwoPlayer}) : super(key: key);

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  List<String> displayElements = List.filled(9, '');
  bool oTurn = true; // 'O' starts the game
  String result = '';

  void tapped(int index) {
    setState(() {
      if (displayElements[index] == '' && result == '') {
        displayElements[index] = oTurn ? 'O' : 'X';
        oTurn = !oTurn;
        checkWinner();

        if (!oTurn && !widget.isTwoPlayer && result == '') {
          Future.delayed(const Duration(seconds: 1), () {
            aiMove();
          });
        }
      }
    });
  }

  void aiMove() {
    List<int> availableSpots = [];
    for (int i = 0; i < displayElements.length; i++) {
      if (displayElements[i] == '') {
        availableSpots.add(i);
      }
    }

    if (availableSpots.isNotEmpty) {
      int aiIndex = availableSpots[Random().nextInt(availableSpots.length)];
      setState(() {
        displayElements[aiIndex] = 'X';
        oTurn = !oTurn;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    // Define the winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      String a = displayElements[combination[0]];
      String b = displayElements[combination[1]];
      String c = displayElements[combination[2]];

      if (a == b && b == c && a != '') {
        setState(() {
          result = '$a wins!';
        });
        return;
      }
    }

    if (!displayElements.contains('')) {
      setState(() {
        result = 'It\'s a tie!';
      });
    }
  }

  void resetGame() {
    setState(() {
      displayElements = List.filled(9, '');
      result = '';
      oTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * 0.7,
            maxWidth: 500,
          ),
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => tapped(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white24,
                    ),
                  ),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        displayElements[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                          decoration: TextDecoration.none,
                          shadows: [
                            Shadow(
                              blurRadius: 40,
                              color: displayElements[index] == 'O'
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (result.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ElevatedButton(
          onPressed: resetGame,
          child: const Text('Restart Game'),
        ),
      ],
    );
  }
}