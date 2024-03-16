import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

// The state class for CategoriesScreen where we manage categories.
class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  Map<int, TextEditingController> _budgetControllers = {};

  // A list to store category data retrieved from the database.
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    // Load categories from the database when the widget is initialized.
    _loadCategories();
  }

  // Retrieves category data from the database and updates the state.
  Future<void> _loadCategories() async {
    _categories = await DatabaseHelper().getCategoryMapList();
    _budgetControllers.clear();
    for (var category in _categories) {
      _budgetControllers[category['id']] = TextEditingController(text: category['budget']?.toString() ?? '');
    }
    setState(() {}); // Update the UI with the new category data.
  }

  // Adds a new category to the database and refreshes the list.
  Future<void> _addCategory(String categoryName) async {
    if (categoryName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Category name cannot be empty')));
      return;
    }
    final int initialBudget = 0; // Define the initial budget here.
    try {
      // Insert the new category into the database.
      await DatabaseHelper().insertCategory(categoryName.trim(), initialBudget);
      _categoryNameController.clear(); // Clear the input field.
      _loadCategories(); // Refresh the category list.
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding category: $e')));      // Handle errors 
    }
  }

  // Updates the budget for a specific category.
  Future<void> _updateBudget(int categoryId, String budget) async {
    if (budget.trim().isEmpty) return; // Don't proceed if the budget
    try {
      final int budgetValue = int.parse(budget); 
      await DatabaseHelper().updateCategoryBudget(categoryId, budgetValue); 
      _loadCategories(); // Reload the category
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating budget: $e')));      // Handle errors
    }
  }

  // Deletes a category by its ID and refreshes the list.
  Future<void> _deleteCategory(int id) async {
    try {
      await DatabaseHelper().deleteCategory(id); // Remove the category from the database.
      _loadCategories(); // Reload the category list to reflect the deletion.
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting category: $e')));// Handle errors
    }
  }

// Screen elements,
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
