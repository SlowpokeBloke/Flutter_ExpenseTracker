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
      body: ListView( 
        padding: const EdgeInsets.all(16.0),
        children: [
          
          Card( // Place holder card will be heavly adjust or completely replace
            elevation: 4.0,
            color: Colors.grey[200],
            child: const Padding(
              padding: EdgeInsets.all(16.0), // Adjust padding for balance card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Monthly Balance',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$ 1100',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('+ 3000.00', style: TextStyle(color: Colors.green)),
                      Text('- 1900', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          ),


          SizedBox(height: 40), 
          
          
          Card( // Mid nav buttons
            elevation: 4.0,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
         






        ],
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
