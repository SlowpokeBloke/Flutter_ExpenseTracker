import 'package:flutter/material.dart';
import './screens/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed:() => {}, icon: const Icon(Icons.person),),  //onpressed: navigates to profile page
            title: const Text('Expense Tracker'),
            centerTitle: true,
            bottom: const TabBar( //consider swapping to bottom edge of screen
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.assignment_outlined)),
                Tab(icon: Icon(Icons.insert_chart_outlined)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              //link to Home, Budget, Charts
              HomeScreen(),
              Goals(),
              Reports(),
            ]
          ),
        ),
      ),
    );
  }
}