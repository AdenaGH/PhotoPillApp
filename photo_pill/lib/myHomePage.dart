import 'package:flutter/material.dart';
import 'package:photo_pill/inputDrugDescription.dart';
import 'package:photo_pill/inputPatientMed.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return InputPatientMed();
                      }),
                    );
                  },
                  child: const Text(
                    'Input Patient Medications',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return InputDrugDescription();
                      }),
                    );
                  },
                  child: const Text(
                    'Input Drug Description',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    print('Clear button pressed');
                  },
                  child: const Text(
                    'Clear Data',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
}
