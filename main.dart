import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true; 
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player O (Bot)',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          oScore.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      _clearScoreBoard();
                    },
                    child: Text("Clear Score Board"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    if (displayElement[index] == '' && oTurn) {
      setState(() {
        displayElement[index] = 'X';
        filledBoxes++;
        oTurn = false;
        _checkWinner();
        if (!oTurn && filledBoxes < 9) {
          _botMove();
        }
      });
    }
  }

  void _botMove() {
    int move = _findWinningMove('O') ?? _findWinningMove('X') ?? _getRandomMove();

    setState(() {
      displayElement[move] = 'O';
      filledBoxes++;
      oTurn = true;
      _checkWinner();
    });
  }

  int _getRandomMove() {
    Random random = Random();
    int move;
    do {
      move = random.nextInt(9);
    } while (displayElement[move] != '');
    return move; 
  }

  int? _findWinningMove(String player) {
    // Winning positions
    List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pos in winningPositions) {
      String a = displayElement[pos[ 0]];
      String b = displayElement[pos[1]];
      String c = displayElement[pos[2]];
      if (a == player && b == player && c == '') {
        return pos[2]; 
      }
      if (a == player && b == '' && c == player) {
        return pos[1]; 
      }
      if (a == '' && b == player && c == player) {
        return pos[0]; 
      }
    }
    return null; 
  }

  void _checkWinner() {
    // Winning positions
    List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pos in winningPositions) {
      String a = displayElement[pos[0]];
      String b = displayElement[pos[1]];
      String c = displayElement[pos[2]];
      if (a == 'X' && b == 'X' && c == 'X') {
        _showDialog('Player X wins!');
        xScore++;
        return;
      } else if (a == 'O' && b == 'O' && c == 'O') {
        _showDialog('Player O wins!');
        oScore++;
        return;
      }
    }

    if (filledBoxes == 9) {
      _showDialog('It\'s a draw!');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _clearBoard();
              },
            ),
          ],
        );
      },
    );
  }

  void _clearBoard() {
    setState(() {
      displayElement = ['', '', '', '', '', '', '', '', ''];
      filledBoxes = 0;
      oTurn = true;
    });
  }

  void _clearScoreBoard() {
    setState(() {
      oScore = 0;
      xScore = 0;
      _clearBoard();
    });
  }
}
