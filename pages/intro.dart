import 'package:flutter/material.dart';
import 'package:memory_game_v2/pages/homepage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Intro_page.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 150.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 225, 222, 222)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 20,
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
                    'PLAY',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'PressStart2P'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
