import 'package:flutter/material.dart';
import './screens/index.dart';

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
      routes: {
        '/home': (context) => HomeScreen(),
        '/budget_goal': (context) => BudgetGoal(),
        '/categories': (context) => CategoriesScreen(),
        '/expense_entry': (context) => ExpenseEntry(),
        '/expense_view': (context) => MyExpensesWidget(),
        '/profile': (context) => Profile(),
        '/visual_report': (context) => VisualReport(),
      },
      home:DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            //leading: IconButton(onPressed:() => {}, icon: const Icon(Icons.person),),  //onpressed: navigates to profile page
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(onPressed:() => {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))}, icon: const Icon(Icons.person),);
              },
            ),
            title: const Text('Expense Tracker'),
            centerTitle: true,
            // bottom: const TabBar( //consider swapping to bottom edge of screen
            //   tabs: [
            //     Tab(icon: Icon(Icons.home)),
            //     Tab(icon: Icon(Icons.assignment_outlined)),
            //     Tab(icon: Icon(Icons.insert_chart_outlined)),
            //   ],
            // ),
          ),
          body: TabBarView(
            children: [
              //link to Home, Budget, Charts
              HomeScreen(),
              //Goals(),
              BudgetGoal(),
              VisualReport(),
            ]
          ),
          bottomNavigationBar: BottomAppBar(child:
            TabBar( //consider swapping to bottom edge of screen
              tabs: [
                Tab(child: Container(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/homeIcon.png'),
                        ),),
                Tab(child: Container(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/goalIcon.png'),
                        ),),
                Tab(child: Container(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/reportIcon.png'),
                        ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}