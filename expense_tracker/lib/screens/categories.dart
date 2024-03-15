
import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _categories = await DatabaseHelper().getCategoryMapList();
    setState(() {});
  }

  Future<void> _addCategory(String categoryName) async {
    await DatabaseHelper().insertCategory({'name': categoryName});
    _controller.clear();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'New Category Name',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _addCategory(_controller.text),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_categories[index]['name']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
