import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
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
    setState(() {});
  }

  Widget _buildPieChart() {
    List<charts.Series<Map<String, dynamic>, String>> seriesList = [
      charts.Series<Map<String, dynamic>, String>(
        id: 'Expenses',
        domainFn: (Map<String, dynamic> category, _) => category['name'] ?? 'Unnamed',
        measureFn: (Map<String, dynamic> category, _) => category['totalExpenses'].abs(),
        data: _categoriesData,
        labelAccessorFn: (Map<String, dynamic> row, _) => '${row['name']}: \$${row['totalExpenses']}',
      ),
    ];

    return Container(
      height: 300, // Adjust the size of the chart
      child: charts.PieChart<String>(
        seriesList,
        animate: true,
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
      body: Column(
        children: [
          _buildPieChart(), // Include the pie chart here.
          Expanded(
            child: ListView.builder(
              itemCount: _categoriesData.length,
              itemBuilder: (context, index) {
                final category = _categoriesData[index];
                final double budget = (category['budget'] as int?)?.toDouble() ?? 0.0;
                final double expenses = (category['totalExpenses'] as int?)?.toDouble() ?? 0.0;
                final double percentage = budget != 0 ? - expenses / budget : 0.0;

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
          ),
        ],
      ),
    );
  }
}

