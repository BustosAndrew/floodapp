import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '',
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
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the row horizontally
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 20),
                                  child: Text(
                                    "Water",
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
                                    padding: const EdgeInsets.only(
                                        bottom: 20, top: 20),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter gallons',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 20),
                                  child: Text(
                                    "Food",
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
                                    padding: const EdgeInsets.only(
                                        bottom: 20, top: 20),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter # of cans',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 20, top: 20),
                                  child: Text(
                                    "Energy",
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
                                    padding: const EdgeInsets.only(
                                        bottom: 20, top: 20),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter hours',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {},
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
                                        Color.fromRGBO(97, 173, 235,
                                            1)), // Set the background color
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
}
