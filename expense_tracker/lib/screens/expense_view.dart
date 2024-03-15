import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class ExpenseView extends StatefulWidget {
 @override
 _ExpenseViewState createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
 List<Map<String, dynamic>> _expenses = [];

 @override
 void initState() {
   super.initState();
   _loadExpenses();
 }

Future<void> _loadExpenses() async {
 // Use DatabaseHelper instance to access the database
 final dbHelper = DatabaseHelper();
 _expenses = await dbHelper.getExpenses();
 setState(() {});
}

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Expense View'),
       backgroundColor: Colors.white,
       foregroundColor: Colors.black,
       centerTitle: true,
       elevation: 2,
     ),
     body: ListView.builder(
       itemCount: _expenses.length,
       itemBuilder: (context, index) {
         final expense = _expenses[index];
         return ListTile(
           leading: Icon(Icons.monetization_on),
           title: Text('${expense['categoryName']}: \$${expense['amount']}'),
           subtitle: Text(expense['description']),
           trailing: Text(expense['date']),
         );
       },
     ),
   );
 }
}
