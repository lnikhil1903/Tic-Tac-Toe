import 'package:flutter/material.dart';

class CustomDialogComponent extends StatelessWidget {
  final String player1Name;
  final int player1Wins;
  final String player2Name;
  final int player2Wins;
  final String resultText;
  final VoidCallback onResetPressed;
  final VoidCallback onRematchPressed;

  CustomDialogComponent({
    required this.player1Name,
    required this.player1Wins,
    required this.player2Name,
    required this.player2Wins,
    required this.resultText,
    required this.onResetPressed,
    required this.onRematchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: MediaQuery.of(context).size.height - 200,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Theme.of(context).colorScheme.onBackground,
              child: Text(
                resultText,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Scoreboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            player1Name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            player2Name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Wins',
                            style: TextStyle(fontSize: 16, color: Colors.brown),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            player1Wins.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            player2Wins.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onResetPressed,
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: onRematchPressed,
                  child: Text(
                    'Rematch',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(
  BuildContext context,
  String player1Name,
  int player1Wins,
  String player2Name,
  int player2Wins,
  String resultText,
  VoidCallback onResetPressed,
  VoidCallback onRematchPressed,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return CustomDialogComponent(
        player1Name: player1Name,
        player1Wins: player1Wins,
        player2Name: player2Name,
        player2Wins: player2Wins,
        resultText: resultText,
        onResetPressed: onResetPressed,
        onRematchPressed: onRematchPressed,
      );
    },
  );
}
