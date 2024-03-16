import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class BudgetGoal extends StatefulWidget {
  @override
  _BudgetGoalState createState() => _BudgetGoalState();
}

class _BudgetGoalState extends State<BudgetGoal> {
  List<Map<String, dynamic>> _categories = []; // Stores category data including budgets

  @override
  void initState() {
    super.initState();
    _loadCategoriesAndBudgets(); // Load categories and their budgets when the screen initializes
  }

  Future<void> _loadCategoriesAndBudgets() async {
    _categories = await DatabaseHelper().getCategoryMapList(); // Assumes this fetches budget info as well
    setState(() {}); // Update the state to reflect new data
  }
 // Bulds the UI elements for the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Budget Goal'), 
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category['name']),
                  Text('Budget: ${category['budget'] ?? 'Not set'}'), // Display budget
                ],
              ),
            );
          },
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