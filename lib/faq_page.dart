import 'package:flutter/material.dart';
import 'package:tutorial/_themed_app_bar.dart';
import 'package:tutorial/constants.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: 'FAQs',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _faqBox(
              'The average time for ER at this facility is...',
              '1 Hour, 33 Minutes',
            ),
            const SizedBox(height: 10),
            _faqBox(
              'Is my Information Safe?',
              'Yes! Patient Inform has hand selected secure tools that help our app remain '
                  'HIPAA compliant and keep your personal health information both safe and secure!',
            ),
            const SizedBox(height: 10),
            _faqBox('Does this have any hidden charges?',
                'No! Patient Inform is completely free to use!'),
            const SizedBox(height: 10),
            _faqBox('How far back does my history go?',
                'We have your 1 year old history.'),
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
