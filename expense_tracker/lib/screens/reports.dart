import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Text('test3'),
    );
  }
}
