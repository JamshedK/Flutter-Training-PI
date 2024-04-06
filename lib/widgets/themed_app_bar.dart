import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';

class ThemedAppBar extends AppBar {
  ThemedAppBar({
    super.key,
    required String title,
    required BuildContext context,
  }) : super(
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.navigate_before_sharp,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Image.asset('assets/PI_menu_icon.png',
                    width: 20.0, height: 16.0),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        );
}
