import 'dart:async';
import 'dart:math';
import '../models/tic_tac_toe_model.dart';

class TicTacToeController {
  final TicTacToeModel model;
  final bool isTwoPlayer;

  TicTacToeController(this.model, this.isTwoPlayer);

  void tapped(int index) {
    if (model.displayElements[index] == '' && model.result == '') {
      model.displayElements[index] = model.oTurn ? 'O' : 'X';
      model.oTurn = !model.oTurn;
      checkWinner();

      if (!model.oTurn && !isTwoPlayer && model.result == '') {
        Future.delayed(const Duration(seconds: 1), () {
          aiMove();
        });
      }
    }
  }

  void aiMove() {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < model.displayElements.length; i++) {
      if (model.displayElements[i] == '') {
        model.displayElements[i] = 'X';
        int score = minimax(model.displayElements, 0, false);
        model.displayElements[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    if (bestMove != -1) {
      model.displayElements[bestMove] = 'X';
      model.oTurn = !model.oTurn;
      checkWinner();
    }
  }

  int minimax(List<String> board, int depth, bool isMaximizing) {
    String result = checkWinnerForMinimax(board);
    if (result != '') {
      if (result == 'X') return 10 - depth;
      if (result == 'O') return depth - 10;
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          int score = minimax(board, depth + 1, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          int score = minimax(board, depth + 1, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  String checkWinnerForMinimax(List<String> board) {
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
      String a = board[combination[0]];
      String b = board[combination[1]];
      String c = board[combination[2]];

      if (a == b && b == c && a != '') {
        return a;
      }
    }

    if (!board.contains('')) {
      return 'tie';
    }

    return '';
  }

  void checkWinner() {
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
      String a = model.displayElements[combination[0]];
      String b = model.displayElements[combination[1]];
      String c = model.displayElements[combination[2]];

      if (a == b && b == c && a != '') {
        model.result = '$a wins!';
        return;
      }
    }

    if (!model.displayElements.contains('')) {
      model.result = 'It\'s a tie!';
    }
  }

  void resetGame() {
    model.displayElements = List.filled(9, '');
    model.result = '';
    model.oTurn = true;
  }
}