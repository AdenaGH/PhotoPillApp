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
      isVisible = false; // Hide the text after adding a medication
    });
  }

  void clearMedicines() {
    setState(() {
      drugNames.clear(); // Clear the list
      isVisible = true; // Show the initial text
    });
  }

  Widget buildMedicineList() {
    if (drugNames.isEmpty) {
      return Visibility(
        child: Text(
          'Click the button to start adding patient medication!',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        visible: isVisible,
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: drugNames.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(8.0), // Adjust padding as needed
              margin: EdgeInsets.symmetric(vertical: 4.0), // Add vertical margin between items
              color: Colors.green, // Set the background color to green
              child: ListTile(
                title: Text(
                  drugNames[index],
                  style: TextStyle(fontSize: 18, color: Colors.white), // Style the text as needed
                ),
              ),
            ),
          );
        },
      );
    }
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
            buildMedicineList(),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        splashColor: Colors.lightBlueAccent,
        onPressed: () {
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
                      if (newDrugName.trim().isNotEmpty) {
                        toggle();
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
