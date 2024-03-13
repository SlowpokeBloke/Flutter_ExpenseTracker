import 'package:flutter/material.dart';

class ExpenseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense View'), 
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        //  body content here
      ),
      
  
    );
  }
}