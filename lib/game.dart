import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/dialog.dart';

class TicTacToeGrid extends StatefulWidget {
  final int gridSize;
  final String player1Name;
  final String player2Name;

  TicTacToeGrid({
    required this.gridSize,
    required this.player1Name,
    required this.player2Name,
  });

  @override
  _TicTacToeGridState createState() => _TicTacToeGridState();
}

class _TicTacToeGridState extends State<TicTacToeGrid> {
  List<String> gridItems = [];
  bool isP1turn = true;

  int p1wins = 0;
  int p2wins = 0;
  String p1 = '';
  String p2 = '';
  String turnMessage = '';
  late ConfettiController controllerTopCenter;
  @override
  void initState() {
    super.initState();

    gridItems =
        List.generate(widget.gridSize * widget.gridSize, (index) => '_');
    p1 = widget.player1Name;
    p2 = widget.player2Name;

    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));

    turnMessage = "$p1's turn ( X )";
  }

  void onRematchForTie() {
    setState(() {
      gridItems =
          List.generate(widget.gridSize * widget.gridSize, (index) => '_');
      isP1turn = true;
      turnMessage = "$p2's turn ( X )";
    });

    // Close the dialog
    Navigator.of(context).pop();
  }

  void onReset() {
    setState(() {
      controllerTopCenter.stop();
      // Reset game state
      gridItems =
          List.generate(widget.gridSize * widget.gridSize, (index) => '_');
      isP1turn = true;

      p1wins = 0;
      p2wins = 0;
      turnMessage = "$p1:     X's turn";
    });

    // Navigate to home screen or any other screen
    Navigator.pop(context);
    Navigator.pop(context); // Close the current screen
  }

  void onRematch() {
    setState(() {
      // Increment player wins for the appropriate player
      controllerTopCenter.stop();
      if (isP1turn) {
        p2wins++;
      } else {
        p1wins++;
      }
      // Reset game state for a rematch
      gridItems =
          List.generate(widget.gridSize * widget.gridSize, (index) => '_');
      isP1turn = true;
      turnMessage = "$p1:     X's turn";
    });

    // Close the dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          children: [
            ConfettiWidget(
              confettiController: controllerTopCenter,
              blastDirectionality:
                  BlastDirectionality.explosive, // blast randomly
              shouldLoop: true, // loop animation
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
            SizedBox(height: 50),
            Container(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              width: containerWidth,
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 5, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'X : $p1',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'V/S',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: Theme.of(context).colorScheme.onTertiary)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'O : $p2',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: containerWidth,
              height: MediaQuery.of(context).size.height - 450,
              child: GridView.builder(
                itemCount: widget.gridSize * widget.gridSize,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridSize,
                ),
                itemBuilder: itemBuilder,
              ),
            ),
            Text(
              turnMessage,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          // Handle grid item tap here
          if (gridItems[index] == '_') {
            setState(() {
              // Update the grid item based on the current player's turn
              gridItems[index] = isP1turn ? 'X' : 'O';
              isP1turn = !isP1turn; // Switch turns
              if (isP1turn)
                turnMessage = "$p1's turn ( X ) ";
              else
                turnMessage = "$p2's turn ( O )";
            });
            checkWinOrTie(
                gridItems,
                widget.gridSize,
                context,
                p1,
                p2,
                p1wins,
                p2wins,
                onReset,
                onRematch,
                onRematchForTie,
                controllerTopCenter);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              gridItems[index], // Display the item from the list
              style: TextStyle(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }
}

void checkWinOrTie(
  List<String> grid,
  int gridSize,
  BuildContext context,
  String p1,
  String p2,
  int p1wins,
  int p2wins,
  VoidCallback onReset,
  VoidCallback onRematch,
  VoidCallback onRematchForTie,
  ConfettiController confettiController,
) {
  String winner = checkForWinner(grid, gridSize);
  String resultText = '';
  if (winner == 'X') {
    resultText = "Congratulations $p1 🥳🙌🎉 you have won this round.!";
    p1wins++;
  } else if (winner == 'O') {
    resultText = "Congratulations $p2 🥳🙌🎉 you have won this round.!";
    p2wins++;
  }

  if (winner != '') {
    // Start confetti
    confettiController.play();

    // Delay showing the dialog
    Future.delayed(Duration(seconds: 2), () {
      showCustomDialog(
          context, p1, p1wins, p2, p2wins, resultText, onReset, onRematch);
    });
  } else if (grid.every((element) => element != '_')) {
    resultText = 'Uh..Oh, the match has tied';

    // Delay showing the dialog

    showCustomDialog(
        context, p1, p1wins, p2, p2wins, resultText, onReset, onRematchForTie);
  }
}

String checkForWinner(List<String> grid, int gridSize) {
  // Check rows
  for (int i = 0; i < gridSize; i++) {
    if (grid[i * gridSize] != '_') {
      bool isWinner = true;
      for (int j = 1; j < gridSize; j++) {
        if (grid[i * gridSize + j] != grid[i * gridSize]) {
          isWinner = false;
          break;
        }
      }
      if (isWinner) {
        return grid[i * gridSize];
      }
    }
  }

  // Check columns
  for (int i = 0; i < gridSize; i++) {
    if (grid[i] != '_') {
      bool isWinner = true;
      for (int j = 1; j < gridSize; j++) {
        if (grid[i + j * gridSize] != grid[i]) {
          isWinner = false;
          break;
        }
      }
      if (isWinner) {
        return grid[i];
      }
    }
  }

  // Check diagonals
  if (grid[0] != '_') {
    bool isWinner = true;
    for (int i = 1; i < gridSize; i++) {
      if (grid[i * (gridSize + 1)] != grid[0]) {
        isWinner = false;
        break;
      }
    }
    if (isWinner) {
      return grid[0];
    }
  }

  if (grid[gridSize - 1] != '_') {
    bool isWinner = true;
    for (int i = 1; i < gridSize; i++) {
      if (grid[(i + 1) * (gridSize - 1)] != grid[gridSize - 1]) {
        isWinner = false;
        break;
      }
    }
    if (isWinner) {
      return grid[gridSize - 1];
    }
  }

  // No winner
  return '';
}
