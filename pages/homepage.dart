import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:memory_game_v2/levels/easy.dart';
import 'package:memory_game_v2/levels/hard.dart';
import 'package:memory_game_v2/levels/medium.dart';
import 'package:memory_game_v2/pages/intro.dart';
import 'package:memory_game_v2/pages/leaderboard.dart';
import 'package:memory_game_v2/pages/developerpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePageContent(),
    Leaderboard(),
    DeveloperPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IntroPage()), // Navigate to IntroPage
        );
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Color(0xFF004aad),
          animationDuration: Duration(milliseconds: 350),
          index: _selectedIndex,
          height: 60,
          items: const [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.leaderboard, color: Colors.white),
            Icon(Icons.info_rounded, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Intro_page.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  ' ',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EasyPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 225, 222, 222)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 39.0)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 15,
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
                    'EASY',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'PressStart2P'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MediumPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 225, 222, 222)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 15,
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
                    'MEDIUM',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'PressStart2P'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HardPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 225, 222, 222)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 15,
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
                    'HARD',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'PressStart2P'),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
              ],
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
                MaterialPageRoute(builder: (context) => IntroPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 174, 172, 172)),
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
              style: TextStyle(color: Colors.black, fontFamily: 'PressStart2P'),
            ),
          ),
        ),
      ],
    );
  }
}
