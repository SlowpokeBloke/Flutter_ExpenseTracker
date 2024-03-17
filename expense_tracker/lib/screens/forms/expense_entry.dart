import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:expense_tracker/helpers/database_helper.dart';

class ExpenseForm extends StatelessWidget {
  const ExpenseForm({super.key});
  @override
    Widget build(BuildContext context) {
      const appTitle = 'Add New Expense';
      return Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          body: const NewExpense(),
        );
    }
}
class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
    NewExpenseState createState() {
      return NewExpenseState();
    }
}
// Create a corresponding State class.
// This class holds data related to the form.
class NewExpenseState extends State<NewExpense> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<NewExpenseState>.
  final _formKey = GlobalKey<FormBuilderState>();
  List<Map<String, dynamic>> _categories = []; // This will hold a list of categories from the database.
  String? _selectedCategory; // This will hold the ID of the selected category.
  final TextEditingController _amountController = TextEditingController(); // To capture the amount entered by the user.
  
  @override
  void initState() {
    super.initState();
    _loadCategories(); // Load the list of categories at startup.
  }

  // Loads categories from the database and updates the UI.
  Future<void> _loadCategories() async {
    _categories = await DatabaseHelper().getCategoryMapList(); // Fetch the list of categories.
    if (_categories.isNotEmpty) {
      _selectedCategory = _categories.first['id'].toString(); // Automatically select the first category.
    }
    setState(() {}); // Refresh the UI with the categories loaded.
  }

  // Called when the user submits their expense entry.
  void _submitExpense() async {
    if (_selectedCategory == null || _amountController.text.isEmpty) {
      // Show an error if no category is selected or if the amount is not entered.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a category and enter an amount')));
      return;
    }
    final int categoryId = int.parse(_selectedCategory!); // Parse the selected category ID.
    final int expenseAmount = int.tryParse(_amountController.text) ?? 0; // Parse the entered amount.

    // Create a map to hold the expense data.
    Map<String, dynamic> expense = {
      'categoryId': categoryId,
      'amount': -expenseAmount, // Store the amount as a negative value, representing an expense.
      'description': 'Expense entry', // Here we simply use a default description. You could add a field for custom descriptions.
      'date': DateTime.now().toIso8601String(), // Store the current date and time as an ISO8601 string.
    };

    // Insert the new expense into the database.
    await DatabaseHelper().insertExpense(expense);

    // Clear the form and show a confirmation message.
    _amountController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Expense added successfully')));

    // No need to call _loadCategories unless you want to display updated budget information.
  }

  @override
    Widget build(BuildContext context) {
      // Build a Form widget using the _formKey created above.
      return FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormBuilderDropdown(
              name: 'category',
              decoration: const InputDecoration(labelText: 'Category'),
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
            ),
            FormBuilderTextField(
              controller: _amountController,
              name: 'expense amount',
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.numeric(),]),
            ),
            // FormBuilderTextField(
            //   name: 'expense description',
            //   decoration: const InputDecoration(labelText: 'Expense Details'),
            //   validator: FormBuilderValidators.compose([FormBuilderValidators.required(),]),
            // ),
            // FormBuilderDateTimePicker(
            //   name: 'dob',
            //   inputType: InputType.date,
            //   decoration: const InputDecoration(labelText: 'Date Of Birth'),
            //   initialDate: DateTime(1990),
            //   validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            //   ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                // Validate and save the form values
                _formKey.currentState?.saveAndValidate();
                debugPrint(_formKey.currentState?.value.toString());
                // On another side, can access all field values without saving form with instantValues
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data...')));
                  _submitExpense();
                }
                debugPrint(_formKey.currentState?.instantValue.toString());
              },
              child: const Text('Submit'),
              ),
            ),
          ],
        ),
      );
    }
}