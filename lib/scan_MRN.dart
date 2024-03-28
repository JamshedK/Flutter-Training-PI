import 'package:flutter/material.dart';
import 'package:tutorial/_themed_app_bar.dart';
import 'package:tutorial/constants.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class scanMRN extends StatelessWidget {
  const scanMRN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: 'Scan QR',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/QR_code.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 10),
            const Text(
              'Scan this QR Code to access Patient Inform, the most innovative, real time update platform for your Emergency Visit.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqBox(titleText, bodyText) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x22000000), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        child: ExpansionTile(
          //Empty border parameter removes default divider lines
          shape: const Border(),
          collapsedIconColor: primaryColor,
          iconColor: primaryColor,
          title: Text(
            titleText,
            style: const TextStyle(fontSize: 14),
          ),
          children: [
            ListTile(
              title: Text(
                bodyText,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
}
