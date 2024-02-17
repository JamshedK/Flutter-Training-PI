import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: primaryColor,
        //   // title: const Text("Hello, Daniel!! :)"),
        // ),
        body: switch (currentPageIndex) {
          1 => HomeScreen2(),
          2 => HomeScreen2(),
          3 => HomeScreen2(),
          _ => HomeScreen1(),
        },
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          // indicatorColor: primaryColor,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: primaryColor),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon:
                  Icon(Icons.notifications_sharp, color: primaryColor),
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Current Visit',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              label: 'History',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(text: "Welcome Back,\n"),
              TextSpan(text: "Daniel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ],
          ),
        ),
      ),
      body: const Text("Page 1"),
    );
  }
}

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.notification_add), Icon(Icons.menu)],
        backgroundColor: primaryColor,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: "Welcome back,\n"),
              TextSpan(text: "Daniel"),
            ],
          ),
        ),
      ),
      body: const Text("Page 2"),
    );
  }
}
