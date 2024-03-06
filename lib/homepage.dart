import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/notifications.dart';
import 'package:tutorial/visits.dart';

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
        // TODO: navigate to correct pages
        body: switch (currentPageIndex) {
          1 => const HomeScreen2(),
          2 => const HomeScreen2(),
          3 => const HomeScreen2(),
          _ => const HomeScreen1(),
        },
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
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

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  // TODO: when timer is set up, add ternary conditional to return plurals (e.g. "Hours" instead of "Hour")
  final List<String> timeUnits = ['Day', 'Hour', 'Min', 'Sec'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homePageAppBar,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _currentVisitInfoBox,
            const SizedBox(height: 12),
            // TODO: first check if there is any previous visit before displaying this box?
            _lastVisitInfoBox
          ]),
        ),
      ),
    );
  }

  AppBar get _homePageAppBar => AppBar(
        centerTitle: false,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(color: primaryTextColor, fontSize: 14),
            children: [
              //TODO: when user is signed in, get their name from the database
              TextSpan(text: 'Welcome Back,\n'),
              TextSpan(
                  text: 'Daniel',
                  style: TextStyle(
                      height: 1.5, fontWeight: FontWeight.bold, fontSize: 22)),
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Image.asset('assets/homepage_notif_bell.png'),
              onPressed: () {
                print('notification');
              }),
          IconButton(
              icon: Image.asset('assets/side_menu_orange.png'),
              onPressed: () {
                print('open side menu');
              })
        ],
      );

  Widget get _currentVisitInfoBox => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: primaryColor,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Current Visit',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            )),
        const SizedBox(height: 8),
        const Text('Reason',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        // TODO: use VistData class to fill in info here
        const Text('Knee fracture',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        const Text('Medications',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        // TODO: use VisitData class
        const Text('Knee surgery and pain killers',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white)),
            const SizedBox(width: 8),
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODO: get from VisitData
                  Text('3:45pm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                  //TODO: get from VisitData
                  Text('Your blood work is back',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ])
          ],
        ),
        const SizedBox(height: 16),
        _visitTimer,
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // TODO: add Navigation to VisitDetails page
            print('check details');
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Check Details',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 18)
      ]));

  Widget get _visitTimer => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        const Text('Total Time Taken',
            style: TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 4; ++i) ...[
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: primaryColor),
                      // TODO: create timer to get actual visit times
                      child: const Text('00',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500))),
                  const SizedBox(height: 8),
                  Text(timeUnits[i],
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500))
                ],
              ),
              if (i != 3) ...[
                const SizedBox(width: 12),
                const Column(
                  children: [
                    Text(':',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 28)
                  ],
                ),
                const SizedBox(width: 12)
              ]
            ]
          ],
        )
      ]));

  Widget get _lastVisitInfoBox => Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x33000000)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO: get actual visit Data
                const Text('Last Visiting Date',
                    style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic)),
                const SizedBox(height: 18),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: primaryTextColor, fontSize: 14),
                    children: [
                      TextSpan(
                          text: 'Total Time\n',
                          style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic)),
                      TextSpan(
                          text: '2 hrs 45 minutes',
                          style: TextStyle(
                              color: primaryTextColor,
                              height: 1.75,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                    ],
                  ),
                ),
              ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('15 July 2023',
                    style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                TextButton(
                  onPressed: () {
                    // TODO: add navigation to VisitDetails page
                    print('view details');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('View Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ]),
        ]),
      ));
}

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  final _items = const [
            PastVisit(visitData: VisitData(dateOfVisit: "2/20/24", reasonForVisit: "intake appt", timeSpent: "1 hour", medications: "pills")),
            PastVisit(visitData: VisitData(dateOfVisit: "2/21/24", reasonForVisit: "treatment", timeSpent: "2 hours", medications: "surgery")),
            PastVisit(visitData: VisitData(dateOfVisit: "2/22/24", reasonForVisit: "checkup", timeSpent: "45 min", medications: "none")),
            PastVisit(visitData: VisitData(dateOfVisit: "2/23/24", reasonForVisit: "evaluation", timeSpent: "1 hour 30 min", medications: "x-ray")),
            PastVisit(visitData: VisitData(dateOfVisit: "2/24/24", reasonForVisit: "checkup", timeSpent: "30 min", medications: "pills")),
          ];

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
