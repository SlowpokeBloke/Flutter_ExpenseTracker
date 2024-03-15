import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        //actions: [IconButton(onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ()))}, tooltip: 'Add New Entry', icon: const Icon(Icons.add_box_rounded))],
      ),
      body: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('PlaceholderName'),
        ],
      ),
    );
  }
}
