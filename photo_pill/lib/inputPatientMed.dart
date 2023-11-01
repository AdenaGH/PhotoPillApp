import 'package:flutter/material.dart';
import 'package:photo_pill/takePicture.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

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
      isVisible = true; // Show the initial  text
    });
  }

  Widget buildMedicineList() {
    if (drugNames.isEmpty) {
      return Visibility(
        child: Text(
          'Click the button to start adding patient medication!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        visible: isVisible,
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: drugNames.length,
        itemBuilder: (context, index) {
          String editedName = drugNames[index];
          return Center(
            child: Container(
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              color: Colors.green,
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        editedName,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String editedDrugName = editedName;
                          return AlertDialog(
                            title: Text('Edit Drug Name'),
                            content: TextField(
                              controller:
                                  TextEditingController(text: editedDrugName),
                              onChanged: (value) {
                                editedDrugName = value;
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  if (editedDrugName.trim().isNotEmpty) {
                                    setState(() {
                                      drugNames[index] = editedDrugName;
                                    });
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure you want to delete?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    drugNames.removeAt(index);
                                  });
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text(
                                  'Yes, I am sure',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child:
                                    Text('No', style: TextStyle(fontSize: 20)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return TakePictureScreen();
                }),
              );
            },
            tooltip: 'Add Items',
            child: const Icon(Icons.camera),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$newDrugName added'),
                              ),
                            );
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
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: clearMedicines,
            child: Text('Clear Medicines'),
          ),
        ],
      ),
    );
  }
}
