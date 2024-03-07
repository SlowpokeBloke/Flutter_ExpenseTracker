import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/budget_goal.dart';
import 'screens/categories.dart';
import 'screens/expense_entry.dart';
import 'screens/expense_view.dart';
import 'screens/profile.dart';
import 'screens/visual_report.dart';



// Import other screens here...

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/budget_goal': (context) => BudgetGoal(),
        '/categories': (context) => Categories(),
        '/expense_entry': (context) => ExpenseEntry(),
        '/expense_view': (context) => ExpenseView(),
        '/profile': (context) => Profile(),
        '/visual_report': (context) => VisualReport(),
      },
      
    );
  }
}
