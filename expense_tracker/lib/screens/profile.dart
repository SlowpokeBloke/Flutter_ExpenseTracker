import 'package:expense_tracker/helpers/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  String _userName = "User Name";
  int _monthlyIncome = 0;

  @override
  void initState() {
    super.initState();
    _loadProfileInfo();
  }

  Future<void> _loadProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? "User Name";
      _monthlyIncome = prefs.getInt('monthlyIncome') ?? 0;
    });
  }

  Future<void> _saveProfileInfo(String userName, int monthlyIncome) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setInt('monthlyIncome', monthlyIncome);
    _loadProfileInfo();
  }

  void _changeProfileInfo() {
    TextEditingController nameController = TextEditingController(text: _userName);
    TextEditingController incomeController = TextEditingController(text: _monthlyIncome.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Enter new name"),
              ),
              TextField(
                controller: incomeController,
                decoration: InputDecoration(hintText: "Enter monthly income"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                _saveProfileInfo(
                  nameController.text,
                  int.tryParse(incomeController.text) ?? 0,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        //actions: [IconButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ()))}, tooltip: 'Add New Entry', icon: const Icon(Icons.add_box_rounded))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100),
            SizedBox(height: 20),
            Text(_userName, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Monthly Income: \$$_monthlyIncome', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeProfileInfo,
              child: Text('Edit Profile'),
            ),
            
// Expense clear button for debuging db issue 

            // ElevatedButton(
            //   onPressed: () async {
            //     await DatabaseHelper().clearAllExpenses();
            //     print("All expenses cleared");
            //   },
            //   child: Text("Clear All Expenses"),
            // )

            
          ],
        ),
      ),
    );
  }
}
