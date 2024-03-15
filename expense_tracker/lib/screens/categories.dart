import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  Map<int, TextEditingController> _budgetControllers = {};

  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _categories = await DatabaseHelper().getCategoryMapList();
    _budgetControllers.clear();
    for (var category in _categories) {
      _budgetControllers[category['id']] = TextEditingController(text: category['budget']?.toString() ?? '');
    }
    setState(() {});
  }

  Future<void> _addCategory(String categoryName) async {
    if (categoryName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Category name cannot be empty')));
      return;
    }
    try {
      await DatabaseHelper().insertCategory({'name': categoryName.trim(), 'budget': 0}); // Assuming initial budget is 0
      _categoryNameController.clear();
      _loadCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding category: $e')));
    }
  }

  Future<void> _updateBudget(int categoryId, String budget) async {
    if (budget.trim().isEmpty) return; // Optionally handle empty string
    try {
      final int budgetValue = int.parse(budget);
      await DatabaseHelper().updateCategoryBudget(categoryId, budgetValue);
      _loadCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating budget: $e')));
    }
  }

  Future<void> _deleteCategory(int id) async {
    try {
      await DatabaseHelper().deleteCategory(id);
      _loadCategories(); // Refresh the list of categories
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting category: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'New Category Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addCategory(_categoryNameController.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final categoryId = category['id'];
                return ListTile(
                  title: Text(category['name']),
                  subtitle: TextField(
                    controller: _budgetControllers[categoryId],
                    decoration: InputDecoration(labelText: 'Budget'),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) => _updateBudget(categoryId, value),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteCategory(categoryId),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _budgetControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
