import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 67, 73, 12), // ···
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.oswald(
            fontSize: 35,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(fontSize: 16),
          displaySmall: GoogleFonts.oswald(fontSize: 28),
          headlineMedium:
              GoogleFonts.raleway(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tic Tac Toe',
          ),
        ),
        body: TicTacToeSettings(),
      ),
    );
  }
}

class TicTacToeSettings extends StatefulWidget {
  @override
  _TicTacToeSettingsState createState() => _TicTacToeSettingsState();
}

class _TicTacToeSettingsState extends State<TicTacToeSettings> {
  int selectedGridSize = 3; // Default grid size
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var player1;
    var player2;
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(121, 61, 46, 8)),
        height: 500,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Grid Size:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            DropdownButton<int>(
              value: selectedGridSize,
              onChanged: (value) {
                setState(() {
                  selectedGridSize = value!;
                });
              },
              items: [3, 4, 5].map((size) {
                IconData icon = Icons.grid_3x3_outlined;
                if (size == 4) {
                  icon = Icons.grid_4x4;
                } else if (size == 5) {
                  icon = Icons.grid_4x4_rounded;
                }

                return DropdownMenuItem<int>(
                  value: size,
                  child: Row(
                    children: [
                      Text('$size x $size',
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(width: 20),
                      Icon(icon)
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: player1Controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(maxWidth: 200),
                  labelText: 'Player 1 Name',
                  labelStyle: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(height: 16),
            TextField(
              controller: player2Controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(maxWidth: 200),
                  labelText: 'Player 2 Name',
                  labelStyle: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (player1Controller.text == '')
                  player1 = 'Player 1';
                else
                  player1 = player1Controller.text;

                if (player2Controller.text == '')
                  player2 = 'Player 2';
                else
                  player2 = player2Controller.text;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicTacToeGrid(
                      gridSize: selectedGridSize,
                      player1Name: player1,
                      player2Name: player2,
                    ),
                  ),
                );
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
