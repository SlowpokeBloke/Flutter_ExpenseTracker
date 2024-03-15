import 'package:flutter/material.dart';

class VisualReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Visual Report'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),

      
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home'); 
                },
                child: Container(
                  width: 60, 
                  height: 60, 
                  child: Image.asset('assets/homeIcon.png'), 
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/budget_goal'); 
                },
                child: Container(
                  width: 60, 
                  height: 60, 
                  child: Image.asset('assets/goalIcon.png'), 
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/visual_report'); 
                },
                child: Container(
                  width: 60, 
                  height: 60, 
                  child: Image.asset('assets/reportIcon.png'), 
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile'); 
                },
                child: Container(
                  width: 60, 
                  height: 60, 
                  child: Image.asset('assets/profileIcon.png'), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
