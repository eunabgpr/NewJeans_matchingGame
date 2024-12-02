import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  Future<void> _clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  String _getGameDifficulty(int score) {
    if (score == 60) {
      return 'Easy';
    } else if (score == 160) {
      return 'Medium';
    } else if (score == 360) {
      return 'Hard';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> _retrieveAllGameData() async {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? userNames = prefs.getStringList('userNames');
      List<Map<String, dynamic>> allGameData = [];

      // Predefined default list for each difficulty
      final defaultPlayers = [
        {'name': 'Euna', 'score': 50, 'time': 25, 'difficulty': 'Easy'},
        {'name': 'Miracle', 'score': 340, 'time': 80, 'difficulty': 'Medium'},
        {'name': 'Geleen', 'score': 700, 'time': 180, 'difficulty': 'Hard'},
        {'name': 'Mathew', 'score': 150, 'time': 45, 'difficulty': 'Easy'},
        {
          'name': 'Cha Eun Woo',
          'score': 350,
          'time': 90,
          'difficulty': 'Medium'
        },
        {'name': 'Angelo', 'score': 355, 'time': 100, 'difficulty': 'Medium'},
        {'name': 'Jullaine', 'score': 700, 'time': 180, 'difficulty': 'Hard'},
      ];

      // Add default list to allGameData
      allGameData.addAll(defaultPlayers);

      if (userNames != null) {
        for (String userName in userNames) {
          if (userName != 'Unknown') {
            final int? score = prefs.getInt('score_$userName');
            final int? time = prefs.getInt('time_$userName');
            final gameDifficulty = _getGameDifficulty(score ?? 0);
            if (gameDifficulty != 'Unknown') {
              allGameData.add({
                'name': userName,
                'score': score ?? 0,
                'time': time ?? 0,
                'difficulty': gameDifficulty,
              });
            }
          }
        }
      }

      allGameData
          .sort((a, b) => (a['time'] as int).compareTo(b['time'] as int));

      // Filter data for each difficulty and get the fastest time for each
      List<Map<String, dynamic>> filteredEasy =
          allGameData.where((data) => data['difficulty'] == 'Easy').toList();
      filteredEasy
          .sort((a, b) => (a['time'] as int).compareTo(b['time'] as int));

      List<Map<String, dynamic>> filteredMedium =
          allGameData.where((data) => data['difficulty'] == 'Medium').toList();
      filteredMedium
          .sort((a, b) => (a['time'] as int).compareTo(b['time'] as int));

      List<Map<String, dynamic>> filteredHard =
          allGameData.where((data) => data['difficulty'] == 'Hard').toList();
      filteredHard
          .sort((a, b) => (a['time'] as int).compareTo(b['time'] as int));

      // Combine the filtered lists
      List<Map<String, dynamic>> combinedData = [];
      if (filteredEasy.isNotEmpty) {
        combinedData.add(filteredEasy[0]);
      }
      if (filteredMedium.isNotEmpty) {
        combinedData.add(filteredMedium[0]);
      }
      if (filteredHard.isNotEmpty) {
        combinedData.add(filteredHard[0]);
      }

      combinedData
          .addAll(allGameData.where((data) => !combinedData.contains(data)));

      return combinedData;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/leaderboard.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder(
          future: _retrieveAllGameData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final List<Map<String, dynamic>> allGameData = snapshot.data ?? [];
            final completedGamesData =
                allGameData.where((data) => data['score'] > 0).toList();
            if (completedGamesData.isEmpty) {
              return Center(
                child: Text('No completed games available.'),
              );
            }
            return Column(
              children: [
                SizedBox(height: 220),
                Expanded(
                  child: ListView.builder(
                    itemCount: completedGamesData.length,
                    itemBuilder: (context, index) {
                      final userData = completedGamesData[index];
                      final bool isTopThree = index < 3;
                      final Color backgroundColor = isTopThree
                          ? Color.fromARGB(255, 146, 71, 141)
                          : Color.fromARGB(255, 65, 75, 124);
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 3.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${userData['name']}',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 250, 250, 250),
                                      fontFamily: 'PressStart2P'),
                                ),
                                Text(
                                  ' ${userData['score']} points',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 250, 250, 250),
                                  ),
                                ),
                                Text(
                                  ' ${userData['time']} seconds',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 250, 250, 250),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 20.0),
                              child: Text(
                                ' ${userData['difficulty']}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 234, 234, 234),
                                  fontFamily: 'PressStart2P',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 2),
                ElevatedButton(
                  onPressed: _clearAllData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 214, 214,
                            214)), // Change this to the color you want
                  ),
                  child: Text(
                    'Clear All Data',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'PressStart2P',
                        fontSize: 10),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
