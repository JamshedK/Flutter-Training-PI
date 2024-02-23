import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  void initState() {
    super.initState();
  }

  final List<bool> _isOpen = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: How to get the default back button?
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text('FAQ\'s',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                )),
            IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _faqBox('The average time for ER at this facility is...',
                '1 Hour, 33 Minutes', 0),
            const SizedBox(height: 10),
            _faqBox(
                'Is my Information Safe?',
                'Yes! Patient Inform has hand selected secure tools that help our app remain '
                    'HIPAA compliant and keep your personal health information both safe and secure!',
                1),
            const SizedBox(height: 10),
            _faqBox('Does this have any hidden charges?',
                'No! Patient Inform is completely free to use!', 2),
            const SizedBox(height: 10),
            _faqBox('How far back does my history go?',
                'We have your 1 year old history.', 3),
          ],
        ),
      ),
    );
  }

  Widget _faqBox(titleText, bodyText, index) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x22000000), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        child: ExpansionPanelList(
          elevation: 0,
          expandIconColor: primaryColor,
          expandedHeaderPadding: const EdgeInsets.all(10),
          children: [
            ExpansionPanel(
              headerBuilder: (context, isOpen) => ListTile(
                title: Text(
                  titleText,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              body: ListTile(
                title: Text(
                  bodyText,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              isExpanded: _isOpen[index],
            ),
          ],
          expansionCallback: (int i, bool isOpen) =>
              setState(() => _isOpen[index] = isOpen),
        ),
      );
}
