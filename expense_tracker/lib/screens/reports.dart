import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports>{
  List<Map<String, dynamic>> _categorizedExpenses = [];
  Map<String, dynamic> catExpMap={};
  Map<String, double> chartMap = {};
  @override
  void initState() {
    super.initState();
    _loadCategorizedExpenses(); // Load the list of categories at startup.
  }

  // Loads categories from the database and updates the UI.
  Future<void> _loadCategorizedExpenses() async {
    _categorizedExpenses = await DatabaseHelper().getTotalExpensesByCategory(); // Fetch the list of categories.
    for (var iter in _categorizedExpenses) {
      catExpMap.addAll(iter);
    }
    print('Data: $catExpMap');
    // toChartMap();
    setState(() {}); // Refresh the UI with the categories loaded.
  }
  // Future toChartMap() async {
  //   chartMap = catExpMap.map((key, value) => MapEntry<String,double>(key, double.parse(value)));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Column( //encompasses all reports content
        children: [
          Card(
            child: 
            PieChart(dataMap: {  //iterate through categories and total expenses in each cat
              'Cat1' : 200.00,
              'Cat2' : 350.48,
              'Cat3' : 32.15,
            }),
            // PieChart(
            //   dataMap:
            // ),
          ),
          //list of prog bars for each cat in goals?
        ],
      ),
    );
  }
}
