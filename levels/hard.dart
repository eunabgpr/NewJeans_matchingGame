import 'package:flutter/material.dart';
import 'package:memory_game_v2/logic/hard_logic.dart';
import 'dart:async';
import 'package:memory_game_v2/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HardPage extends StatefulWidget {
  const HardPage({Key? key}) : super(key: key);

  @override
  State<HardPage> createState() => HardPageState();
}

class TimerWidget extends StatelessWidget {
  final int secondsPassed;

  const TimerWidget({Key? key, required this.secondsPassed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int minutes = secondsPassed ~/ 60;
    int seconds = secondsPassed % 60;

    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Text(
          'Time: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
            decoration: TextDecoration.none,
            fontFamily: 'PressStart2P',
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class HardPageState extends State<HardPage> {
  Future<void> _saveGameData(
      int score, int secondsPassed, String playerName) async {
    final prefs = await SharedPreferences.getInstance();
    final playerScoreKey = 'score_$playerName';
    final playerTimeKey = 'time_$playerName';
    final playerDifficultyKey = 'difficulty_$playerName'; // Add difficulty key

    prefs.setInt(playerScoreKey, score);
    prefs.setInt(playerTimeKey, secondsPassed);
    prefs.setString(playerDifficultyKey, 'Hard'); // Set difficulty to Hard

    // Add the player name to the list of user names
    List<String> userNames = prefs.getStringList('userNames') ?? [];
    if (!userNames.contains(playerName)) {
      userNames.add(playerName);
      await prefs.setStringList('userNames', userNames);
    }
  }

  Future<List<Map<String, dynamic>>> _retrieveAllGameData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? userNames = prefs.getStringList('userNames');
    List<Map<String, dynamic>> allGameData = [];
    if (userNames != null) {
      for (String userName in userNames) {
        final int? score = prefs.getInt('score_$userName');
        final int? time = prefs.getInt('time_$userName');
        final String? difficulty =
            prefs.getString('difficulty_$userName'); // Get difficulty
        allGameData.add({
          'name': userName,
          'score': score ?? 0,
          'time': time ?? 0,
          'difficulty':
              difficulty ?? 'Unknown', // Default to 'Unknown' if not available
        });
      }
    }
    return allGameData;
  }

  Game_Hard _game = Game_Hard();
  int tries = 0;
  int score = 0;
  late Timer _timer;
  int secondsPassed = 0;
  int maxMoves = 72;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _game.initGame();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secondsPassed++;
      });
    });
  }

  void _restartGame(String playerName) {
    _saveGameData(score, secondsPassed, playerName);
    setState(() {
      tries = 0;
      score = 0;
      secondsPassed = 0;
      _timer.cancel();
      _game.initGame();
      _startTimer();
    });
  }

  Future<void> _showGameOverDialog() async {
    await _saveGameData(score, secondsPassed, 'Unknown');
    String? playerName;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Out of moves!'),
                Text('Return to Home Page'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCongratulationsDialog() async {
    await _saveGameData(score, secondsPassed, 'Unknown');
    String? playerName;

    _timer.cancel();
    int minutes = secondsPassed ~/ 60;
    int seconds = secondsPassed % 60;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You have matched all the cards in ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}!',
                ),
                Text('Please enter your name:'),
                TextFormField(
                  onChanged: (value) {
                    playerName = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                if (playerName != null && playerName!.isNotEmpty) {
                  _restartGame(playerName!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background7_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display tries
                Text(
                  'Moves: $tries',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'PressStart2P',
                  ),
                ),
                // Display score
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'PressStart2P',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                TimerWidget(secondsPassed: secondsPassed),
                SizedBox(
                  height: 490,
                  width: 400,
                  child: GridView.builder(
                    itemCount: _game.gameImg!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5.0,
                      mainAxisExtent: 75.0,
                      childAspectRatio: 10.0,
                    ),
                    padding: EdgeInsets.all(30.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: maxMoves > 0
                            ? () {
                                setState(() {
                                  tries++;
                                  maxMoves--;
                                  _game.gameImg![index] =
                                      _game.cards_list[index];
                                  _game.matchCheck
                                      .add({index: _game.cards_list[index]});
                                });

                                if (_game.matchCheck.length == 2) {
                                  if (_game.matchCheck[0].values.first ==
                                      _game.matchCheck[1].values.first) {
                                    score += 30;
                                    _game.matchCheck.clear();
                                  } else {
                                    Future.delayed(Duration(milliseconds: 200),
                                        () {
                                      setState(() {
                                        _game.gameImg![_game.matchCheck[0].keys
                                            .first] = _game.hiddenCardPath;
                                        _game.gameImg![_game.matchCheck[1].keys
                                            .first] = _game.hiddenCardPath;
                                        _game.matchCheck.clear();
                                      });
                                    });
                                  }
                                }

                                if (_game.gameImg!.every(
                                    (card) => card != _game.hiddenCardPath)) {
                                  _showCongratulationsDialog();
                                } else if (maxMoves == 0) {
                                  _showGameOverDialog();
                                }
                              }
                            : null,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey<String>(_game.gameImg![index]),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(_game.gameImg![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: 50.0,
              left: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 174, 172, 172)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                  textStyle: MaterialStateProperty.all(TextStyle(
                    fontSize: 13,
                  )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                      side: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(10.0),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'PressStart2P'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
