import 'package:expense_tracker/screens/forms/edit_categories.dart';
import 'package:flutter/material.dart';
import './expense_view.dart';
import './forms/expense_entry.dart';

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
            //expense preview list below as appbar, new expense in actions, list in flex space
      body: Column( //encompasses all home content
        children: [
          //overview section
          const Card( //remove const; potentially not const after inputs provided?
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //need methods to return Inc, Exp, Bal
                children: [
                  Text(
                    'Total Balance',  //displays output
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Income'), //displays output
                      Text('Total Expense'), //displays output
                    ],
                  )
                ],
              ),
            ),
          ),
          //expense log section
          AppBar(
            //title: const Text('Expense Log'),
            //actions: [IconButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) =>   ExpenseForm()))}, tooltip: 'Add New Entry', icon: const Icon(Icons.add_box_rounded))],
            flexibleSpace: Column(
              mainAxisSize: MainAxisSize.min,
              children:[
                Card(  //display expense log list preview (limit to 3?); expand on tap (to expense log page?)
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      ElevatedButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseView()))}, child: const Text('View Expense Log')),
                      ElevatedButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryForm()))}, child: const Text('View Categories')),
                    ]
                  ),
                ),
                ElevatedButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) =>   ExpenseForm()))}, child: const Text('Add New Entry'),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
