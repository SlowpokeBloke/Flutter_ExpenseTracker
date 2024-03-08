import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class BudgetGoal extends StatefulWidget {
  @override
  _BudgetGoalState createState() => _BudgetGoalState();
}

class _BudgetGoalState extends State<BudgetGoal> {
  List<String> _categories = [];
  
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }
  
  // Load categories from forms in categories.dart
  Future<void> _loadCategories() async {
    final file = await _localFile;
    if (await file.exists()) {
      String contents = await file.readAsString();
      List<dynamic> jsonCategories = jsonDecode(contents);
      setState(() {
        _categories = jsonCategories.cast<String>();
      });
    }
  }

  // Get local file path for storing categories
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/categories.json');
  }

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
        child: _categories.isEmpty
            ? Center(child: Text("No categories found. Please add categories first."))
            : ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_categories[index]),
                   
                    onTap: () {

                    },
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
              // Use GestureDetector to handle taps and increase icon size
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
