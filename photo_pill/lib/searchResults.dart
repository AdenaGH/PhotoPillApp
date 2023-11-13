import 'dart:async';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart'
    show XmlDocument, XmlElement; // Import the xml package

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//this method retrieves the rxcui string given the list of patient meds
// WE NEED TO REPLACE THIS API CALL WITH getApproximateMatch, it returns a ranked ordering of rxcui, we can potentially call each one and see which one returns
Future<Map<String, dynamic>> findRxcuiByString(String drugName) async {
  final String baseUrl = 'https://rxnav.nlm.nih.gov/REST/rxcui.xml';

  // Define the parameters for the API call
  final Map<String, dynamic> firstParams = {
    'name': drugName,
    'search':
        '2', // Set to '0' for exact match, 1 for normalized match, and 2 for best match
  };

  // Build the full URL with parameters
  final Uri uri = Uri.parse(baseUrl).replace(queryParameters: firstParams);
  final http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final XmlDocument xmlDoc = XmlDocument.parse(response.body);
    final rxNormIdElements = xmlDoc.findAllElements('rxnormId');
    String rxcui = rxNormIdElements.single.innerText;
    print(rxcui); //prints rxcui, use this for properties call
    //now call second api
    final String baseUrl2 = 'https://rxnav.nlm.nih.gov/REST/ndcproperties.json';

    final Map<String, dynamic> secondParams = {
      'id': rxcui,
      'ndcstatus': 'ALL',
    };
    final Uri uri2 = Uri.parse(baseUrl2).replace(queryParameters: secondParams);
    final http.Response response2 = await http.get(uri2);
    if (response2.statusCode == 200) {
      try {
        // Parse the response body directly as JSON
        print(json.decode(response2.body));
        Map<String, dynamic> properties = json.decode(response2.body);
        return properties;
      } catch (e) {
        throw Exception('Failed to parse JSON response');
      }
    } else {
      throw Exception(
          'Failed to load NDC properties: ${response.reasonPhrase}');
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load drug');
  }
}

/*
//this method returns the drug properties given the list of drug rxcui ids
Future<Map<String, dynamic>> getNDCProperties(String rxcui) async {
  final String baseUrl = 'https://rxnav.nlm.nih.gov/REST/ndcproperties.json';

  final Map<String, dynamic> params = {
    'id': rxcui,
    'ndcstatus': 'ALL',
  };

  final Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);
  final http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    try {
      // Parse the response body directly as JSON
      Map<String, dynamic> parsed = json.decode(response.body);
      return parsed;
    } catch (e) {
      throw Exception('Failed to parse JSON response');
    }
  } else {
    throw Exception('Failed to load NDC properties: ${response.reasonPhrase}');
  }
}*/

void main() => runApp(const searchResults());

class searchResults extends StatefulWidget {
  const searchResults({super.key});

  @override
  State<searchResults> createState() => _searchResults();
}

class _searchResults extends State<searchResults> {
  late Future<Map<String, dynamic>> properties;

  @override
  void initState() {
    super.initState();
    properties = findRxcuiByString(
        "Lipitor + 10 + mg + Tab"); //hardedcoded for now, need to pass in list of drugs and modify other function as a for loop
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
          child: FutureBuilder<Map<String, dynamic>>(
            future: properties,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.toString());
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
