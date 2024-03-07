import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'), 
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Center the card in the middle of the screen
          child: Card(
            elevation: 4.0,
            color: Colors.grey[200], // Adjust the color to match your design
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Adjust padding to fit your content within the card
              child: Column(
                mainAxisSize: MainAxisSize.min, // Take the minimum space necessary
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: <Widget>[
                      IconButton(
                        icon: Container(
                          width: 80, 
                          height: 80, 
                          child: Image.asset('assets/category.png'), 
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/categories'); 
                        },
                      ), 

                      IconButton(
                        icon: Container(
                          width: 80, 
                          height: 80, 
                          child: Image.asset('assets/receipt.png'), 
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/expense_view'); 
                        },
                      ), 


                    ],
                  ),
                  IconButton(
                    icon: Container(
                      width: 80, 
                      height: 80, 
                      child: Image.asset('assets/+.png'), 
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/expense_entry'); 
                    },
                  ), 
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Use GestureDetector to handle taps and increase icon size
              GestureDetector(
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
