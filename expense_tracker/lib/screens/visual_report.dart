import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expense_tracker/helpers/database_helper.dart';

class VisualReport extends StatefulWidget {
  @override
  _VisualReportState createState() => _VisualReportState();
}

class _VisualReportState extends State<VisualReport> {
  List<Map<String, dynamic>> _categoriesData = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoriesData();
  }

  Future<void> _fetchCategoriesData() async {
    _categoriesData = await DatabaseHelper().getCategoriesWithTotalExpenses();
    print("Fetched categories data: $_categoriesData"); // Debug print
    setState(() {});
  }


  Widget _buildPieChart() {
    // First, we'll convert the categories data into a format suitable for the pie chart.
    final List<Map<String, dynamic>> pieData = _categoriesData.map((category) {
      return {
        'name': category['name'],
        'value': category['totalExpenses'], // This assumes 'totalExpenses' is already calculated.
      };
    }).toList();

    List<charts.Series<Map<String, dynamic>, String>> seriesList = [
      charts.Series<Map<String, dynamic>, String>(
        id: 'Expenses',
        domainFn: (Map<String, dynamic> row, _) => row['name'],
        measureFn: (Map<String, dynamic> row, _) => row['value'],
        data: pieData,
        labelAccessorFn: (Map<String, dynamic> row, _) => '${row['name']}: \$${row['value']}',
      ),
    ];

    return Container(
      height: 300, // Adjust the size of the chart
      child: charts.PieChart(
        seriesList,
        animate: true,
        // Configure the aesthetics of the pie chart here.
        defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [charts.ArcLabelDecorator()],
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Visual Report'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: _categoriesData.length,
        itemBuilder: (context, index) {
          final category = _categoriesData[index];
          final double budget = (category['budget'] as int?)?.toDouble() ?? 0.0;
          final double expenses = (category['totalExpenses'] as int?)?.toDouble() ?? 0.0;
          final double percentage = (budget != 0) ? - expenses / budget : 0.0;

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(category['name'] ?? 'Unnamed Category'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Budget: \$${budget.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: percentage.clamp(0.0, 1.0), 
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percentage >= 1 ? Colors.red : Colors.green,
                      ),
                    ),
                  SizedBox(height: 8),
                  Text('Expenses: \$${expenses.toStringAsFixed(2)}'),
                ],
              ),
            ),
          );
        },
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
