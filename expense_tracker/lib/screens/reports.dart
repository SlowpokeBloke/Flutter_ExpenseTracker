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
    //_categorizedExpenses = await DatabaseHelper().getTotalExpensesByCategory(); // Fetch the list of categories.
    //tmp.forEach((element) {chartMap.addAll(element));};

   // print('Data: $catExpMap');
    // toChartMap();
    setState(() {}); // Refresh the UI with the categories loaded.
  }
  Map<String,double> toChartMap() {
    Map<String,double> map = {};
    //_categorizedExpenses.forEach((iter) => map[iter['cat']]=double.parse(iter['amt']));
   // _categorizedExpenses.forEach((element) {map.addEntries(element['cat']);map.addEntries(element['amt']);});
    // return map;
    // //chartMap = catExpMap.map((key, value) => MapEntry<String,double>(key, double.parse(value)));
    //Map<String, double> map = Map.fromIterable(_categorizedExpenses, key: (iter) => iter.cat, value:(iter) => double.parse(iter.amt));
    //Map<String, double> map = {'cat1':30.1,'cat2':123.34};
    return map;
  }
  @override
  Widget build(BuildContext context) {
    var map = toChartMap();
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
            //   dataMap: map,
            // ),
          ),
          //list of prog bars for each cat in goals?
        ],
      ),
    );
  }
}
