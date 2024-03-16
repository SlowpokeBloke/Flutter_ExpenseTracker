import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});
  
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
            child: PieChart(dataMap: {  //iterate through categories and total expenses in each cat
              'Cat1' : 200.00,
              'Cat2' : 350.48,
              'Cat3' : 32.15,
            }),
          ),
          //list of prog bars for each cat in goals?
        ],
      ),
    );
  }
}
