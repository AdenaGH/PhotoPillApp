import 'package:flutter/material.dart';
import 'package:photo_pill/searchResults.dart';
import 'package:provider/provider.dart';
import 'MedicationProvider.dart';
import 'drug.dart';

class InputDrugDescription extends StatefulWidget {
  const InputDrugDescription({Key? key}) : super(key: key);

  @override
  _InputDrugDescriptionState createState() => _InputDrugDescriptionState();
}

class _InputDrugDescriptionState extends State<InputDrugDescription> {
  bool isCheckedMg = false;
  bool isCheckedMl = false;
  bool isVisible = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController shapeController = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Drug Description'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height *
            0.95, // Set height to 75% of the screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Enter drug name or initial characters",
              ),
            ),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: "Id",
                hintText: "first digit(s) of rxcui id you remember",
              ),
            ),
            TextField(
              controller: colorController,
              decoration: InputDecoration(
                labelText: "Color",
              ),
            ),
            TextField(
              controller: shapeController,
              decoration: InputDecoration(
                  labelText: "Shape",
                  hintText: "round, ellipitical, oval, etc"),
            ),
            TextField(
              controller: sizeController,
              decoration: InputDecoration(
                  labelText: "Size", hintText: "in mm, Ex: 10 mm, 20 mm, etc"),
            ),
            ElevatedButton(
              onPressed: () {
                final medicationProvider =
                    Provider.of<MedicationProvider>(context, listen: false);
                List<String> drugList = medicationProvider.drugList;
                if (drugList.isEmpty) {
                  // Show an alert dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Drug list is empty. Please add drugs before trying to search.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Drug descriptionDrug = Drug(
                      nameController.text,
                      idController.text,
                      colorController.text,
                      shapeController.text,
                      sizeController
                          .text); //Drug that we build given our descriptions
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          searchResults(descriptionDrug: descriptionDrug),
                    ),
                  );
                }
              },
              child: const Text(
                'Search',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
