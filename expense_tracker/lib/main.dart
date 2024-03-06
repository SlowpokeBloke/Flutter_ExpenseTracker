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
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: HomeScreen(),
      // routes: {
      //   '/home': (context) => HomeScreen(),
      //   '/budget_goal': (context) => BudgetGoal(),
      //   '/categories': (context) => Categories(),
      //   '/expense_entry': (context) => ExpenseEntry(),
      //   '/expense_view': (context) => ExpenseView(),
      //   '/profile': (context) => Profile(),
      //   '/visual_report': (context) => VisualReport(),
      // },
      home:DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
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
            ]
          ),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//}



