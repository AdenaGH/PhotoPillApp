// inputPatientMed.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MedicationProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InputPatientMed extends StatefulWidget {
  const InputPatientMed({Key? key}) : super(key: key);

  @override
  _InputPatientMedState createState() => _InputPatientMedState();
}

class _InputPatientMedState extends State<InputPatientMed> {
  final TextEditingController _newDrugNameController = TextEditingController();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _loadDrugList();
  }

  @override
  void dispose() {
    _newDrugNameController.dispose();
    super.dispose();
  }

  Future<void> _loadDrugList() async {
    final prefs = await SharedPreferences.getInstance();
    final drugList = prefs.getStringList('drugList') ?? [];
    final medicationProvider = Provider.of<MedicationProvider>(context, listen: false);
    medicationProvider.setDrugList(drugList);
  }

  Future<void> _saveDrugList(List<String> drugList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('drugList', drugList);
  }

  Widget buildMedicineList() {
    final medicationProvider = Provider.of<MedicationProvider>(context);
    final drugList = medicationProvider.drugList;

    return drugList.isEmpty
        ? Text('No medications added.')
        : Column(
            children: drugList.map((drugName) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                tileColor: Colors.green,
                title: Text(
                  drugName,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    medicationProvider.removeDrugName(drugName);
                    final updatedDrugList = [...medicationProvider.drugList];
                    _saveDrugList(updatedDrugList);
                  },
                ),
              );
            }).toList(),
          );
  }

  void clearMedicines() {
    final medicationProvider = Provider.of<MedicationProvider>(context, listen: false);
    medicationProvider.clearMedicines();
    isVisible = true;
    _saveDrugList([]);
  }

  @override
  Widget build(BuildContext context) {
    final medicationProvider = Provider.of<MedicationProvider>(context);

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
            backgroundColor: Colors.lightBlue,
            splashColor: Colors.lightBlueAccent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add Drug Name'),
                    content: TextField(
                      controller: _newDrugNameController,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          final newDrugName = _newDrugNameController.text;
                          if (newDrugName.trim().isNotEmpty) {
                            _newDrugNameController.clear();
                            medicationProvider.addDrugName(newDrugName);

                            final updatedDrugList = [...medicationProvider.drugList];
                            _saveDrugList(updatedDrugList);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$newDrugName added'),
                              ),
                            );

                            setState(() {
                              isVisible = false;
                            });

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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: clearMedicines,
            child: Text('Clear Medicines'),
          ),
        ],
      ),
    );
  }

}
