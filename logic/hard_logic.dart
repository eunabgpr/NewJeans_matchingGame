import 'package:flutter/material.dart';

class Game_Hard {
  final String hiddenCardPath = 'assets/images/backcard4.jpg';
  List<String>? gameImg;
  List<Color>? gameColors;

  //images
  final List<String> cards_list = [
    "assets/images/photocard1.png",
    "assets/images/photocard1.png",
    "assets/images/photocard2.png",
    "assets/images/photocard2.png",
    "assets/images/photocard3.png",
    "assets/images/photocard3.png",
    "assets/images/photocard4.png",
    "assets/images/photocard4.png",
    "assets/images/photocard5.png",
    "assets/images/photocard5.png",
    "assets/images/photocard6.png",
    "assets/images/photocard6.png",
    "assets/images/photocard7.png",
    "assets/images/photocard7.png",
    "assets/images/photocard8.png",
    "assets/images/photocard8.png",
    "assets/images/photocard9.png",
    "assets/images/photocard9.png",
    "assets/images/photocard10.png",
    "assets/images/photocard10.png",
    "assets/images/photocard11.png",
    "assets/images/photocard11.png",
    "assets/images/photocard12.png",
    "assets/images/photocard12.png",
  ];

  //two first click match
  List<Map<int, String>> matchCheck = [];
  final int cardCount = 24;

  void initGame() {
    // Shuffle the cards
    cards_list.shuffle();
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
  }
}
