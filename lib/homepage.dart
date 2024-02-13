import 'package:flutter/material.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello, Daniel! :)"),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc), 
            label: 'ABC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bakery_dining_sharp), 
            label: 'bread!',
          ),
        ]),
      )
    );
  }
}