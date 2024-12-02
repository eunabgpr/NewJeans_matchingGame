import 'package:flutter/material.dart';

class Game {
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
  ];

  //two first click match
  List<Map<int, String>> matchCheck = [];
  final int cardCount = 12;

  void initGame() {
    // Shuffle the cards
    cards_list.shuffle();
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
  }
}
