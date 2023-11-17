import 'package:flutter/material.dart';
import 'package:photo_pill/searchResults.dart';

class InputDrugDescription extends StatefulWidget {
  const InputDrugDescription({Key? key}) : super(key: key);

  @override
  _InputDrugDescriptionState createState() => _InputDrugDescriptionState();
}

class _InputDrugDescriptionState extends State<InputDrugDescription> {
  bool isCheckedMg = false;
  bool isCheckedMl = false;
  bool isVisible = true;
  List<String> drugDescriptions = []; // List to store drug names

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
            const TextField(
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Enter drug name or initial characters",
              ),
            ),
            // want to add checkbox here for mg or ml
            // need to find a way to concorprate dosage into Drug field
            const TextField(
              decoration: InputDecoration(
                labelText: "Dosage",
                hintText: "Enter dosage amount",
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("mg"),
                    value: isCheckedMg,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedMg = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("ml"),
                    value: isCheckedMl,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedMl = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                )
              ],
            ),
            const TextField(
              // currently open ended, could make this drop down in the future
              decoration: InputDecoration(
                labelText: "Dosage Form",
                hintText: "Ex: Tablet, Capsule, Powder, Oral, Injection, etc",
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Color",
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Purpose",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  //need to add checks for if druglist is empty
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const searchResults();
                    }),
                  );
                },
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
