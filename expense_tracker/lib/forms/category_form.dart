// // lib/forms/category_form.dart
// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:expense_tracker/forms/category_form.dart'; // Replace with the actual path to your Category model

// class CategoryForm extends StatefulWidget {
//   @override
//   _CategoryFormState createState() => _CategoryFormState();
// }

// class _CategoryFormState extends State<CategoryForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _goalController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _goalController.dispose();
//     super.dispose();
//   }

//   void _createCategory() {
//     if (_formKey.currentState!.validate()) {
//       final newCategory = Category(
//         id: DateTime.now().toString(),
//         name: _nameController.text,
//         goal: double.tryParse(_goalController.text) ?? 0,
//       );

//       // TODO: Add logic to save the new category to the state or local storage

//       // Clear the form
//       _nameController.clear();
//       _goalController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//             controller: _nameController,
//             decoration: const InputDecoration(labelText: 'Category Name'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter a category name';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _goalController,
//             decoration: const InputDecoration(labelText: 'Goal Amount'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter a goal amount';
//               }
//               if (double.tryParse(value) == null) {
//                 return 'Please enter a valid number';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: _createCategory,
//               child: const Text('Create Category'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
