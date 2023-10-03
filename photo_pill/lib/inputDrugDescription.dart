import 'package:flutter/material.dart';

class InputDrugDescription extends StatefulWidget {
  const InputDrugDescription({Key? key}) : super(key: key);

  @override
  _InputDrugDescriptionState createState() => _InputDrugDescriptionState();
}

class _InputDrugDescriptionState extends State<InputDrugDescription> {
  bool isVisible = true;
  List<String> drugDescriptions = []; // List to store drug names

  void toggle() {
    setState(() {
      isVisible = false;
    });
  }

  void addDrugName(String name) {
    setState(() {
      drugDescriptions.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Drug Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              child: Text(
                'Click the button to start adding drug descriptions!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              visible: isVisible,
            ),
            SizedBox(height: 20),
            // Display the list of drug names
            ListView.builder(
              shrinkWrap: true,
              itemCount: drugDescriptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(drugDescriptions[index]),
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
                title: Text('Add Drug Description'),
                content: TextField(
                  onChanged: (value) {
                    newDrugName = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // remove on screen prompt text
                      toggle();
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
