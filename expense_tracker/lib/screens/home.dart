import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      //need box with centered balance + income on left bottom, expense on right bottom
      //expense preview list below as appbar, new expense in actions, list in flex space
      body: const Column( 
        children: [
          SizedBox(
            width: null,
            height: 50,
            child: ColoredBox(
              color: Colors.grey,
              child: Column(
                children: [
                  Text('Total'),
                ]
              ),
            ),
          )
          // ColoredBox(
          //   color: Colors.grey,
          //   child: Row(
          //     children: [
          //       Text('Total Income'),
          //       Text('Total Expenses'),
          //     ]
          //   ),
          // ),
        ],
      ),
    );
  }
}
