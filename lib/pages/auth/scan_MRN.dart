import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/widgets/form_box.dart';
import 'package:patient_inform/pages/auth/signup_form.dart';
import 'package:patient_inform/widgets/form_helpers.dart';
import 'package:patient_inform/pages/homepage.dart';
import 'package:patient_inform/utils/user_auth.dart';

class ScanMRN extends StatefulWidget {
  const ScanMRN({super.key});

  @override
  State<ScanMRN> createState() => _ScanMRNState();
}

class _ScanMRNState extends State<ScanMRN> {
  @override
  void initState() {
    super.initState();

    _idController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();

    super.dispose();
  }

  late final TextEditingController _idController;

  String _idError = '';

  var authHandler = UserAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Scan Your MRN Bracelet',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Click the button below to scan the QR code on your MRN bracelet.',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              const Icon(Icons.qr_code_scanner_rounded, size: 160),
              const SizedBox(height: 32),
              // TODO: Implement QR code reader
              _scanMRNButton,
              const SizedBox(height: 12),
              _skipMRNButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _scanMRNButton => TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const Homepage();
          }));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Scan MRN',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      );

  Widget get _skipMRNButton => TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const Homepage();
          }));
        },
        child: const Text(
          'Not checked into the ER? Skip this step.',
          style: TextStyle(color: primaryColor, fontSize: 16),
        ),
      );
}
