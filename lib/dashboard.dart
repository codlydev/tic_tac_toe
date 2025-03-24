import 'package:flutter/material.dart';
import 'tic_tac_toe_board.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TicTacToeBoard(isTwoPlayer: true),
                ),
              );
            },
            child: const Text('Two Players'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TicTacToeBoard(isTwoPlayer: false),
                ),
              );
            },
            child: const Text('Play with AI'),
          ),
        ],
      ),
    );
  }
}