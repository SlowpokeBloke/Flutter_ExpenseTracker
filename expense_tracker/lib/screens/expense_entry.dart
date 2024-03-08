import 'package:flutter/material.dart';

class ExpenseEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Entry'), 
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        // Your body content here
      ),

    );
  }
}
