import 'dart:async';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart'
    show XmlDocument, XmlElement; // Import the xml package

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Drug> findRxcuiByString(String drugName) async {
  final String baseUrl = 'https://rxnav.nlm.nih.gov/REST/rxcui.xml';

  // Define the parameters for the API call
  final Map<String, dynamic> params = {
    'name': drugName,
    'search':
        '2', // Set to '0' for exact match, 1 for normalized match, and 2 for best match
  };

  // Build the full URL with parameters
  final Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);
  print(uri);
  final http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final XmlDocument xmlDoc = XmlDocument.parse(response.body);
    final rxNormIdElements = xmlDoc.findAllElements('rxnormId');
    String rxcui = rxNormIdElements.single.innerText;
    print(rxcui); //prints rxcui, use this for properties call
    Drug drug = Drug.fromXml(xmlDoc.rootElement);
    return drug;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load drug');
  }
}

class Drug {
  final int userId;
  final int id;
  final String name;

  const Drug({
    required this.userId,
    required this.id,
    required this.name,
  });

  factory Drug.fromXml(XmlElement element) {
    return Drug(
      userId: int.parse(element.findElements('userId').first.text),
      id: int.parse(element.findElements('rxNormId').first.text),
      name: element.findElements('name').first.text,
    );
  }
}

void main() => runApp(const searchResults());

class searchResults extends StatefulWidget {
  const searchResults({super.key});

  @override
  State<searchResults> createState() => _searchResults();
}

class _searchResults extends State<searchResults> {
  late Future<Drug> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = findRxcuiByString(
        "tylenol"); //hardedcoded for now, need to pass in list of drugs and modify other function as a for loop
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Drug>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
