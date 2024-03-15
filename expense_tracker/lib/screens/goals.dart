import 'package:flutter/material.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Goals'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        //actions: [IconButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ()))}, tooltip: 'Add New Entry', icon: const Icon(Icons.add_box_rounded))],
      ),
      body: const Text('test2'),
    );
  }
}
