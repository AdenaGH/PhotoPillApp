import 'package:flutter/material.dart';

class InputPatientMed extends StatelessWidget {
  const InputPatientMed({super.key});
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Patient Medications'),
        ),
        body: Center(
          child:  Column(
            FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add items to list',
            child: const Icon(Icons.add),
          ), 
          ),// This trailing comma makes auto-formatting nicer for build methods.
        ));
  }*/
  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    void toggle() {
      isVisible = false;
    }

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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        splashColor: Colors.lightBlueAccent,
        onPressed: toggle,
        tooltip: 'Add Items',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
