import 'package:flutter/material.dart';

class InputPatientMed extends StatefulWidget {
  const InputPatientMed({Key? key}) : super(key: key);

  @override
  _InputPatientMedState createState() => _InputPatientMedState();
}

class _InputPatientMedState extends State<InputPatientMed> {
  bool isVisible = true;
  List<String> drugNames = []; // List to store drug names

  void toggle() {
    setState(() {
      isVisible = false;
    });
  }

  void addDrugName(String name) {
    setState(() {
      drugNames.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Patient Medications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              child: Text(
                'Click the button to start adding patient medication!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              visible: isVisible,
            ),
            SizedBox(height: 20),
            // Display the list of drug names
            ListView.builder(
              shrinkWrap: true,
              itemCount: drugNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(drugNames[index]),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        splashColor: Colors.lightBlueAccent,
        onPressed: () {
          // Show a dialog to input drug name
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newDrugName = '';
              return AlertDialog(
                title: Text('Add Drug Name'),
                content: TextField(
                  onChanged: (value) {
                    newDrugName = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Add the drug name to the list
                      if (newDrugName.isNotEmpty) {
                        addDrugName(newDrugName);
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Items',
        child: const Icon(Icons.add),
      ),
    );
  }
}
