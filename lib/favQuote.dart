import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/randomquotes.dart';
import 'package:share_plus/share_plus.dart';
import 'quote.dart';

class FavoriteQuotesPage extends StatefulWidget {
  final RandomQuote randomQuotes;

  const FavoriteQuotesPage({required this.randomQuotes, super.key});

  @override
  _FavoriteQuotesPageState createState() => _FavoriteQuotesPageState();
}

class _FavoriteQuotesPageState extends State<FavoriteQuotesPage> {
  late List<Quote> favoriteQuotes;

  @override
  void initState() {
    super.initState();
    favoriteQuotes = widget.randomQuotes.getFavoriteQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Quotes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: favoriteQuotes.isEmpty
          ? const Center(
              child: Text(
                'No favorite quotes added yet!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 100, 34, 103),
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteQuotes.length,
              itemBuilder: (context, index) {
                final quote = favoriteQuotes[index];
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.quote,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '- ${quote.author}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 100, 34, 103),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  color:
                                      const Color.fromARGB(255, 100, 34, 103),
                                  onPressed: () {
                                    Share.share(
                                        '${quote.quote} - ${quote.author}');
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, quote);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Quote quote) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Quote"),
          content: const Text("Are you sure you want to delete this quote?"),
          actions: [
            TextButton(
              onPressed: () {
                widget.randomQuotes.removeFromFavorites(quote);
                setState(() {
                  favoriteQuotes = widget.randomQuotes.getFavoriteQuotes();
                });
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
