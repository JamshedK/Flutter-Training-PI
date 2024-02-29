import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/notifications.dart';

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
              TextSpan(
                  text: "Daniel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
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
        actions: const [Icon(Icons.notification_add), Icon(Icons.menu)],
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

/// Leads to the notifcations page.
/// Creates instances of notifcations and renderes them onto the page.
/// @author: Ameer Ghazal
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  final _notifications = const [
    PastNotification(
        notificationData: NotificationData(
            timeOfDay: "02:15 A.M.",
            reasonOfNotification: "Your ER Lab data has finished.")),
    PastNotification(
        notificationData: NotificationData(
            timeOfDay: "05:00 P.M.",
            reasonOfNotification: "Hello, I am under the water.")),
    PastNotification(
        notificationData: NotificationData(
            timeOfDay: "09:32 P.M.",
            reasonOfNotification: "Hello World, 2. Coming, 2025.")),
    PastNotification(
        notificationData: NotificationData(
            timeOfDay: "10:30 P.M.",
            reasonOfNotification:
                "Your CT scan analysis is complete, please come pick it up.")),
  ];

// TODO: Generalize this code among all the side pages (e.g., appbar for FAQ, notifcations, etc.)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.navigate_before_sharp,
                  color: Colors.white,
                ),
              )
            : null,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: _notifications.length,
          itemBuilder: (_, index) => _notifications[index],
        ),
      ),
    );
  }
}
