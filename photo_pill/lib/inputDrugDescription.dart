import 'package:flutter/material.dart';

class InputDrugDescription extends StatefulWidget {
  const InputDrugDescription({Key? key}) : super(key: key);

  @override
  _InputDrugDescriptionState createState() => _InputDrugDescriptionState();
}

class _InputDrugDescriptionState extends State<InputDrugDescription> {
  bool isVisible = true;
  List<String> drugDescriptions = []; // List to store drug names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Drug Description'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height *
            0.95, // Set height to 75% of the screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Enter drug name or initial characters",
              ),
            ),
            // want to add checkbox here for mg or ml
            TextField(
              decoration: InputDecoration(
                labelText: "Dosage",
                hintText: "Enter dosage amount",
              ),
            ),
            TextField(
              // currently open ended, could make this drop down in the future
              decoration: InputDecoration(
                labelText: "Dosage Form",
                hintText: "Ex: Tablet, Capsule, Powder, Oral, Injection, etc",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Color",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Purpose",
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
