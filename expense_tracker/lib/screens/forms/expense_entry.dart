import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
              items: [], //List<DropdownMenuItem<TXT(fetch categories)>[]
            ),
            FormBuilderTextField(
              name: 'expense amount',
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.numeric(),]),
            ),
            FormBuilderTextField(
              name: 'expense description',
              decoration: const InputDecoration(labelText: 'Expense Details'),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required(),]),
            ),
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data...')));}
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