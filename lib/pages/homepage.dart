import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_inform/pages/faq_page.dart';
import 'package:patient_inform/utils/database.dart';
import 'package:patient_inform/utils/user_records.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/pages/notifications.dart';
import 'package:patient_inform/pages/current_visit_page.dart';
import 'package:patient_inform/pages/profile_screen.dart';
import 'package:patient_inform/pages/visit_details.dart';
import 'package:patient_inform/pages/past_visits.dart';

// Store the user data.
final String? userID = FirebaseAuth.instance.currentUser?.uid;
// Database service to store the user data.
final DatabaseService<UserRecords> _databaseService =
    DatabaseService<UserRecords>(
  APPICATION_USERS_COLLECTION_REF,
  fromFirestore: (snapshot, _) => UserRecords.fromJson(snapshot.data()!),
  toFirestore: (userRecord, _) => userRecord.toJson(),
);

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
        body: switch (currentPageIndex) {
          1 => const CurrentVisitPage(),
          2 => const PastVisitsPage(),
          3 => const ProfilePage(),
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
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon:
                  Image.asset("assets/navbar/home_clicked.png", scale: 1.5),
              icon: Image.asset("assets/navbar/HOME.png",
                  scale: 1.5), // Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Image.asset("assets/navbar/currvisit_clicked.png",
                  scale: 1.5),
              icon: Image.asset("assets/navbar/CURRVISIT.png",
                  scale: 1.5), // Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Current Visit',
            ),
            NavigationDestination(
              selectedIcon:
                  Image.asset("assets/navbar/history_clicked.png", scale: 1.5),
              icon: Image.asset("assets/navbar/HISTORY.png", scale: 1.5),
              label: 'History',
            ),
            NavigationDestination(
              selectedIcon:
                  Image.asset("assets/navbar/PROFILE_CLICKED.png", scale: 1.5),
              icon: Image.asset("assets/navbar/PROFILE.png", scale: 1.5),
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
  final List<String> timeUnits = ['Hour', 'Min'];
  final List<String> visitTimes = ['01', '45'];

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
        title: StreamBuilder(
          stream: _databaseService.getUserData(userID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Store the user's data.
            var userRecord = snapshot.data!.data()! as UserRecords;
            var firstName = userRecord.firstName;

            return RichText(
              text: TextSpan(
                style: const TextStyle(color: primaryTextColor, fontSize: 14),
                children: [
                  const TextSpan(text: 'Welcome Back,\n'),
                  TextSpan(
                      text: firstName,
                      style: const TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
              icon: Image.asset('assets/homepage_notif_bell.png'),
              onPressed: () {
                print('notification');
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const NotificationsPage();
                }));
              }),
          IconButton(
              icon: const Icon(Icons.help_outline_rounded,
                  color: primaryColor, size: 32),
              onPressed: () {
                print('having trouble?');
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const FAQPage();
                }));
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VisitDetailsPage()),
            );
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
        const Text('Estimated Wait Time',
            style: TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 2; ++i) ...[
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
                      child: Text(visitTimes[i],
                          style: const TextStyle(
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
              if (i != 1) ...[
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const VisitDetailsPage()),
                    );
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

Widget get _createMRNButton => TextButton(
      onPressed: () async {
        print("Scan your MRN");
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: RichText(
            text: const TextSpan(
              //style: StyleElement(),
              children: [
                TextSpan(
                    text: 'Scan your MRN  ',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ],
            ),
          )),
    );

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
            reasonOfNotification: "A triage nurse is ready to see you.")),
    PastNotification(
        notificationData: NotificationData(
            timeOfDay: "09:32 P.M.",
            reasonOfNotification: "Your blood test results have returned.")),
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


/// Gets the current user's name that is logged in.
