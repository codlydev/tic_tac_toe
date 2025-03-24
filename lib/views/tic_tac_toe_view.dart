import 'package:flutter/material.dart';
import '../controllers/tic_tac_toe_controller.dart';
import '../models/tic_tac_toe_model.dart';

class TicTacToeView extends StatefulWidget {
  final bool isTwoPlayer;
  const TicTacToeView({Key? key, required this.isTwoPlayer}) : super(key: key);

  @override
  State<TicTacToeView> createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  late TicTacToeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TicTacToeController(TicTacToeModel(), widget.isTwoPlayer);
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
                onTap: () => setState(() => _controller.tapped(index)),
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
                        _controller.model.displayElements[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                          decoration: TextDecoration.none,
                          shadows: [
                            Shadow(
                              blurRadius: 40,
                              color: _controller.model.displayElements[index] == 'O'
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
        if (_controller.model.result.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _controller.model.result,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ElevatedButton(
          onPressed: () => setState(() => _controller.resetGame()),
          child: const Text('Restart Game'),
        ),
      ],
    );
  }
}