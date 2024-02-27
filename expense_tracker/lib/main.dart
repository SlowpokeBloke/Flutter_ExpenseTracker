import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, user'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        // This would be your page content
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                // Handle your button tap here
              },
              child: Image.asset(
                'assets/homeIcon.png',
                width: 65, // Set your desired width
                height: 75, // Set your desired height
              ),
            ),
            InkWell(
              onTap: () {
                // Handle your button tap here
              },
              child: Image.asset(
                'assets/goalIcon.png',
                width: 65,
                height: 75,
              ),
            ),
            InkWell(
              onTap: () {
                // Handle your button tap here
              },
              child: Image.asset(
                'assets/reportIcon.png',
                width: 65,
                height: 75,
              ),
            ),
            InkWell(
              onTap: () {
                // Handle your button tap here
              },
              child: Image.asset(
                'assets/profileIcon.png',
                width: 65,
                height: 75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
