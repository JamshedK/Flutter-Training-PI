import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';

class NotificationData {
  const NotificationData({
    required this.timeOfDay,
    required this.reasonOfNotification,
  });

  final String timeOfDay;
  final String reasonOfNotification;
}

// TODO: Determine if the notifcations will be a drop-down / clickable / expandable.
class PastNotification extends StatelessWidget {
  const PastNotification({super.key, required this.notificationData});

  final NotificationData notificationData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD4D4D4),
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "./assets/PI-Avatar.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notificationData.timeOfDay,
                  style: const TextStyle(
                      color: grayColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.5)),
              Container(
                // TODO: Fix Row overflow, instead of hard-coded constraint (EXAPANDED).
                constraints: const BoxConstraints(maxWidth: 275),
                child: Text(
                  notificationData.reasonOfNotification,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0E0E0E),
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


// TODO: Generalize this code among all the side pages (e.g., appbar for FAQ, notifcations, etc.)

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: primaryColor,
//       iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
//       leading: Navigator.canPop(context)
//           ? IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.navigate_before_sharp,
//                 color: Colors.white,
//               ),
//             )
//           : null,
//       centerTitle: true,
//       title: const Text(
//         "Notifications",
//         style: TextStyle(color: Colors.white, fontSize: 16),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 16.0),
//           child: IconButton(
//             icon: const Icon(Icons.menu),
//             color: Colors.white,
//             onPressed: () {},
//           ),
//         )
//       ],
//     ),
//     body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Color(0xFFD4D4D4),
//                       width: 1.0,
//                     ),
//                   ),
//                 ),
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 spreadRadius: 0,
//                                 blurRadius: 5,
//                                 offset: const Offset(0, 0),
//                               ),
//                             ],
//                           ),
//                           child: ClipOval(
//                             child: CircleAvatar(
//                               radius: 25,
//                               backgroundColor: Colors.white,
//                               child: Image.asset(
//                                 "./assets/PI-Avatar.png",
//                                 fit: BoxFit.cover,
//                                 alignment: Alignment.center,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 16,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(notificationData.timeOfDay,
//                             style: const TextStyle(
//                                 color: grayColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12,
//                                 height: 1.5)),
//                         Text(
//                           notificationData.reasonOfNotification,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff0E0E0E),
//                             fontSize: 16,
//                             height: 2,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )),
//   );
// }
