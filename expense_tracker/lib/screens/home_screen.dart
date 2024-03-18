import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _monthlyIncome = 0;
  int _totalExpenses = 0;

  @override
  void initState() {
    super.initState();
    _loadFinancialInfo(); 
  }

  Future<void> _loadFinancialInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final dbHelper = DatabaseHelper();
    int totalExpenses = await dbHelper.getTotalExpenses();
    setState(() {
      _monthlyIncome = prefs.getInt('monthlyIncome') ?? 0;
      _totalExpenses = totalExpenses;
    });
  }

  Future<void> deleteExpense(int expenseId) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteExpense(expenseId);
    refreshExpenses(); 
  }


  Future<void> refreshExpenses() async {
  final dbHelper = DatabaseHelper();
  int totalExpenses = await dbHelper.getTotalExpenses();
  setState(() {
      _totalExpenses = totalExpenses.abs(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    int displayExpenses = _totalExpenses.abs(); // Ensure positive display
    int remainingBalance = _monthlyIncome - displayExpenses;
    print("Remaining balance: $remainingBalance, Total expenses: $_totalExpenses");


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        // ... other AppBar properties
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            // Adjusted card to display the financial information
            elevation: 4.0,
            color: Colors.grey[200],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Monthly Income',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$$_monthlyIncome',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '+ \$${remainingBalance.toString()}',
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        '\$$_totalExpenses',
                        style: TextStyle(color: Colors.red),
                      ),
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
