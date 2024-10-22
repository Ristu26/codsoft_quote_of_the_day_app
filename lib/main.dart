import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/randomquotes.dart';
import 'package:share_plus/share_plus.dart';
import 'favQuote.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RandomQuoteGenerator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandomQuoteGenerator extends StatelessWidget {
  const RandomQuoteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuotePage();
  }
}

RandomQuote randomQuotes = RandomQuote();

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  void _shareQuote(String quote, String author) {
    Share.share('$quote - $author');
  }

  void _addToFavorites() {
    setState(() {
      randomQuotes.addToFavorites();
      randomQuotes.showToast("Quote added :)");
    });
  }

  void _refreshQuote() {
    setState(() {
      randomQuotes.nextQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quote Of The Day App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 98, 95),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteQuotesPage(
                    randomQuotes: randomQuotes,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white30,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                randomQuotes.getQuoteText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 100, 35, 103),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '- ${randomQuotes.getQuoteAuthor()}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 100, 34, 103),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.teal,
                    onPressed: _addToFavorites,
                    tooltip: 'Add to Favorites',
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    color: Colors.teal,
                    onPressed: _refreshQuote,
                    tooltip: 'Refresh Quote',
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    color: Colors.teal,
                    onPressed: () {
                      _shareQuote(
                        randomQuotes.getQuoteText(),
                        randomQuotes.getQuoteAuthor(),
                      );
                    },
                    tooltip: 'Share Quote',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
