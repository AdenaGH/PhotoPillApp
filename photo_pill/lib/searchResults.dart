import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  _SearchResults createState() => _SearchResults();
}

class _SearchResults extends State<SearchResults> {
  final List<String> results = [
    'Result 1',
    'Result 2',
    'Result 3',
    'Result 4',
    'Result 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(results[index]),
            onTap: () {
              // Handle the tap on a search result here
              // You can navigate to a detail page or perform other actions.
            },
          );
        },
      ),
    );
  }
}
