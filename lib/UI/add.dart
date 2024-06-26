import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flood/model/supply.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatelessWidget {
  // Creating text editing controllers to capture input
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _energyController = TextEditingController();

  void submitData(BuildContext context) async {
    // Capture the input data
    double waterLevel = double.tryParse(_waterController.text) ?? 0.0;
    double foodCount = double.tryParse(_foodController.text) ?? 0.0;
    double energyHours = double.tryParse(_energyController.text) ?? 0.0;

    // Get the current user's UID
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Reference to the user's document in the 'users' collection
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

      // Update or set the user's data
      await userDocRef.update({
        'water': waterLevel,
        'food': foodCount,
        'energy': energyHours,
        'timestamp': FieldValue.serverTimestamp(), // Adding a timestamp
      }).catchError((error) {
        // If the document does not exist, set the data instead of updating
        userDocRef.set({
          'water': waterLevel,
          'food': foodCount,
          'energy': energyHours,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      // Optionally, navigate back or show a success message
      Navigator.pop(context);
    } else {
      // Handle the case when the user is not logged in
      print('No user logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Supplies',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF0E1A68), // Light blue at the bottom
                  Color(0xFF263DA8), // Darker blue at the top
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 49, left: 9, bottom: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 363,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildInputField(
                                    'Water', 'Enter gallons', _waterController),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Water you waiting for?"),
                                          content: Text(
                                            "DUring a flood you might loose access to clean water. We recommend storing at least 50 gallons. This should be enough for drinking and sanitation purposes.",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 55.0),
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                _buildInputField(
                                    'Food', 'Enter # of cans', _foodController),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Can do attitude!"),
                                          content: Text(
                                            "While it depends on the type of canned food stored, we estimate you should stock roughly 3 cans per person per day, totaling around 50 cans.",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 65.0),
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                _buildInputField(
                                    'Energy', 'Enter hours', _energyController),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("How much energy?"),
                                          content: Text(
                                            "For a power outage, you should have enough backup energy stored to last you for at least 72 hours. To last roughly up to a week with limited use.",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 45.0),
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () => submitData(context),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(97, 173, 235, 1)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, String hintText, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 20, top: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
