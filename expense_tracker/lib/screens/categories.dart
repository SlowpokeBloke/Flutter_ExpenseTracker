import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _controller = TextEditingController();
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

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

  Future<File> _saveCategories() async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(_categories));
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/categories.json');
  }

  void _addCategory() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _categories.add(_controller.text.trim());
        _controller.clear();
        _saveCategories();
      });
    }
  }

  void _deleteCategory(int index) {
    setState(() {
      _categories.removeAt(index);
      _saveCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Add New Category',
                suffixIcon: IconButton(
                  onPressed: _addCategory,
                  icon: Icon(Icons.add),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_categories[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () => _deleteCategory(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
