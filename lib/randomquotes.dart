import 'dart:math';
import 'package:flutter/material.dart';
import 'quote.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RandomQuote {
  int _quoteNumber = 0;
  final List<Quote> favoriteQuotes = [];

  void addToFavorites() {
    final currentQuote = _quoteData[_quoteNumber];
    if (!favoriteQuotes.contains(currentQuote)) {
      favoriteQuotes.add(currentQuote);
    }
  }

  List<Quote> getFavoriteQuotes() {
    return favoriteQuotes;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color.fromARGB(255, 100, 34, 103),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  final List<Quote> _quoteData = [
    Quote(1, "The best way to predict your future is to create it.",
        "Peter Drucker"),
    Quote(
        2,
        "In the end, we will remember not the words of our enemies, but the silence of our friends.",
        "Martin Luther King Jr."),
    Quote(3, "Act as if what you do makes a difference. It does.",
        "William James"),
    Quote(4, "You miss 100% of the shots you don't take.", "Wayne Gretzky"),
    Quote(5, "It always seems impossible until it’s done.", "Nelson Mandela"),
    Quote(
        6,
        "The only limit to our realization of tomorrow will be our doubts of today.",
        "Franklin D. Roosevelt"),
    Quote(
        7,
        "Your time is limited, so don’t waste it living someone else’s life.",
        "Steve Jobs"),
    Quote(8, "Do what you can, with what you have, where you are.",
        "Theodore Roosevelt"),
    Quote(
        9,
        "Success usually comes to those who are too busy to be looking for it.",
        "Henry David Thoreau"),
    Quote(
        10,
        "The future belongs to those who believe in the beauty of their dreams.",
        "Eleanor Roosevelt"),
    Quote(
        11, "The journey of a thousand miles begins with one step.", "Lao Tzu"),
  ];

  String getQuoteText() {
    return _quoteData[_quoteNumber].quote;
  }

  String getQuoteAuthor() {
    return _quoteData[_quoteNumber].author;
  }

  void nextQuote() {
    _quoteNumber = Random().nextInt(_quoteData.length);
  }

  void removeFromFavorites(Quote quote) {
    favoriteQuotes.remove(quote);
  }
}
