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
        elevation: 2,
      ),
      body: const Text('test2'),
    );
  }
}
