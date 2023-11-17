import 'dart:async';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart'
    show XmlDocument, XmlElement; // Import the xml package

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_pill/search.dart';
import 'drug.dart';
import 'package:provider/provider.dart';
import 'MedicationProvider.dart';

//this method retrieves the rxcui string given the list of patient meds
// WE NEED TO REPLACE THIS API CALL WITH getApproximateMatch, it returns a ranked ordering of rxcui, we can potentially call each one and see which one returns
Future<List<Map<String, dynamic>>> returnProperties(
    List<String> drugNames) async {
  const String baseUrl = 'https://rxnav.nlm.nih.gov/REST/rxcui.xml';
  List<Map<String, dynamic>> apiRespFinal = [];

  for (int i = 0; i < drugNames.length; i++) {
    try {
      final Map<String, dynamic> firstParams = {
        'name': drugNames[i],
        'search': '2',
      };

      final Uri uri = Uri.parse(baseUrl).replace(queryParameters: firstParams);
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final XmlDocument xmlDoc = XmlDocument.parse(response.body);
        final rxNormIdElements = xmlDoc.findAllElements('rxnormId');
        String rxcui = rxNormIdElements.single.innerText;
        print("RXCUI: $rxcui");
        const String baseUrl2 =
            'https://rxnav.nlm.nih.gov/REST/ndcproperties.json';

        final Map<String, dynamic> secondParams = {
          'id': rxcui,
          'ndcstatus': 'ALL',
        };

        final Uri uri2 =
            Uri.parse(baseUrl2).replace(queryParameters: secondParams);
        final http.Response response2 = await http.get(uri2);
        if (response2.statusCode == 200) {
          Map<String, dynamic> jsonMap = json.decode(response2.body);
          print(jsonMap);
          List<Drug> formattedDrugs = ReferenceList.fetch(
              jsonMap); //ERROR here, not sure why works fine when manually testing with "Lipitor+10+mg+Tab"
          apiRespFinal.add(
              {'originalName': drugNames[i], 'formattedDrugs': formattedDrugs});
        } else {
          throw Exception(
              'Failed to load NDC properties: ${response2.reasonPhrase}');
        }
      } else {
        throw Exception('Failed to load drug: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle errors for individual drugs
      print('Error for drug ${drugNames[i]}: $e');
    }
  }

  return apiRespFinal;
}
/*
Future<List<Drug>> formattedProperties(
    List<Map<String, dynamic>> propertyResponse) async {
  try {
    // Wait for the propertyResponse to complete
    Map<String, dynamic> properties = await propertyResponse;
    // Process the properties and create a List<Drug>
    List<Drug> drugs = ReferenceList.fetch(properties);
    return drugs;
  } catch (e) {
    // Handle any errors that might occur
    print('Error formatting properties: $e');
    return [];
  }
}*/

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
  late Future<List<Map<String, dynamic>>> properties;
  //late Future<List<Drug>> formattedProp = Future.value([]);

  @override
  void initState() {
    super.initState();
    //properties = returnProperties(
    //"Lipitor + 10 + mg + Tab"); //hardedcoded for now, need to pass in list of drugs and modify other function as a for loop
    final medicationProvider =
        Provider.of<MedicationProvider>(context, listen: false);
    List<String> drugList = medicationProvider.drugList;
    properties = returnProperties(drugList);
    print(properties);
    /*
    properties.then((propertyMap) {
      formattedProp = formattedProperties(Future.value(propertyMap));
      setState(() {});
    });*/
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
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: properties,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No data available.');
              }

              List<Map<String, dynamic>> drugDataList = snapshot.data!;

              return ListView.builder(
                itemCount: drugDataList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> drugData = drugDataList[index];
                  List<Drug> drugs = drugData['formattedDrugs'];

                  return Column(
                    children: [
                      ListTile(
                        title:
                            Text('Original Name: ${drugData['originalName']}'),
                        // Add other information related to the original drug name
                      ),
                      // Now iterate over the formatted drugs
                      ...drugs.map((drug) => ListTile(
                            title: Text(drug.name),
                            // Add other properties as needed
                          )),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
