import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/widgets/form_box.dart';
import 'package:patient_inform/widgets/form_helpers.dart';
import 'package:patient_inform/pages/homepage.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm({super.key});

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _mobileNumberController = TextEditingController();
  }

  @override

  /// Disposes the controllers used.
  /// Controllers run in the background with listeners.
  /// Thus, it is better to dispose them.
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _mobileNumberController.dispose();

    super.dispose();
  }

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _mobileNumberController;

  String _firstNameError = '';
  String _lastNameError = '';
  String _dateOfBirthError = '';
  String _mobileNumberError = '';
  String required = 'This field is required';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/logo.png'),
              const Text(
                'Enter Personal Details',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Enter personal information below',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              FormBox(
                icon: Icons.person_2_outlined,
                hintText: 'First Name',
                controller: _firstNameController,
                keyboardType: TextInputType.name,
              ),
              ...FormHelpers.checkError(_firstNameError),
              const SizedBox(height: 16),
              FormBox(
                icon: Icons.person_2_outlined,
                hintText: 'Last Name',
                controller: _lastNameController,
                keyboardType: TextInputType.name,
              ),
              ...FormHelpers.checkError(_lastNameError),
              const SizedBox(height: 16),
              FormBox(
                icon: Icons.calendar_month_outlined,
                hintText: 'Date Of Birth',
                controller: _dateOfBirthController,
                keyboardType: TextInputType.number,
              ),
              ...FormHelpers.checkError(_dateOfBirthError),
              const SizedBox(height: 16),
              FormBox(
                icon: Icons.phone_outlined,
                hintText: 'Mobile Number',
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                // TODO: Use input formatters to modify keyboard interface?
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.digitsOnly,
                //   LengthLimitingTextInputFormatter(12), // Adjust according to your phone number format
                //   also try MaskTextInputFormatter to enforce a specific format
                // ],
              ),
              ...FormHelpers.checkError(_mobileNumberError),
              const SizedBox(height: 16),
              _createNextButton,
            ],
          ),
        ),
      ),
    );
  }

  // TODO: This should theoretically make the below code cleaner but the 'required' text doesn't show...
  // void updateErrorState(TextEditingController controller, String errorField) {
  //   setState(() {
  //     if (controller.text.isEmpty) {
  //       errorField = required;
  //     } else {
  //       errorField = '';
  //     }
  //   });
  // }

  Widget get _createNextButton => TextButton(
        onPressed: () {
          _firstNameController.text.isEmpty
              ? setState(() {
                  _firstNameError = required;
                })
              : setState(() {
                  _firstNameError = '';
                });
          _lastNameController.text.isEmpty
              ? setState(() {
                  _lastNameError = required;
                })
              : setState(() {
                  _lastNameError = '';
                });
          _dateOfBirthController.text.isEmpty
              ? setState(() {
                  _dateOfBirthError = required;
                })
              : setState(() {
                  _dateOfBirthError = '';
                });
          _mobileNumberController.text.isEmpty
              ? setState(() {
                  _mobileNumberError = required;
                })
              : setState(() {
                  _mobileNumberError = '';
                });
          // do not continue if any fields are blank
          bool allClear = _firstNameController.text.isNotEmpty &&
              _lastNameController.text.isNotEmpty &&
              _dateOfBirthController.text.isNotEmpty &&
              _mobileNumberController.text.isNotEmpty;
          if (allClear) {
            print(
                'First/last name: "${_firstNameController.text}"/"${_lastNameController.text}"');
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const Homepage();
            }));
          }
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
            'Next',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      );
}
