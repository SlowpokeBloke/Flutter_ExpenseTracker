import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});
  @override
    Widget build(BuildContext context) {
      const appTitle = 'Add New Expense';
      return Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          body: const NewCategory(),
        );
    }
}
class NewCategory extends StatefulWidget {
  const NewCategory({super.key});
  @override
    NewCategoryState createState() {
      return NewCategoryState();
    }
}
// Create a corresponding State class.
// This class holds data related to the form.
class NewCategoryState extends State<NewCategory> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<NewCategoryState>.
  final _formKey = GlobalKey<FormBuilderState>();
  @override
    Widget build(BuildContext context) {
      // Build a Form widget using the _formKey created above.
      return FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormBuilderTextField(
              //key: field specific key
              name: 'name',
              decoration: const InputDecoration(labelText: 'Name'),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            ),
            FormBuilderTextField(
              name: 'budget',
              decoration: const InputDecoration(labelText: 'Budget'),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.numeric()]),
            ),
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