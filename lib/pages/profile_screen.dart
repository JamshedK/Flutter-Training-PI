import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/utils/database.dart';
import 'package:patient_inform/utils/user_records.dart';
import 'package:patient_inform/widgets/form_helpers.dart';
import 'package:patient_inform/pages/scan_MRN.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Store the user ID.
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  // Database service to store the user data.
  final DatabaseService<UserRecords> _databaseService =
      DatabaseService<UserRecords>(
    APPICATION_USERS_COLLECTION_REF,
    fromFirestore: (snapshot, _) => UserRecords.fromJson(snapshot.data()!),
    toFirestore: (userRecord, _) => userRecord.toJson(),
  );

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with empty values.
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();

    // Fetch the user info from the database.
    _databaseService.getUserData(userID).listen(
      (snapshot) {
        if (snapshot.exists) {
          // Get the specific user data.
          userRecord = snapshot.data() as UserRecords;
          print(userRecord);

          // Set the state on the input fields, if applicable.
          setState(() {
            _firstNameController =
                TextEditingController(text: userRecord.firstName ?? '');
            _lastNameController =
                TextEditingController(text: userRecord.lastName ?? '');
            _emailController =
                TextEditingController(text: userRecord.emailAddress ?? '');
            _phoneNumberController =
                TextEditingController(text: userRecord.cellNumber ?? '');
          });
        }
      },
      onError: (error) {
        print('Error fetching patient data: $error');
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  // Controllers and User-Record.
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late UserRecords userRecord;

  void _updatePatientData() {
    // Create a new PatientRecords object with updated data (that is applicable).
    UserRecords updatedUserRecord = UserRecords(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      emailAddress: _emailController.text,
      cellNumber: _phoneNumberController.text,
      dateOfBirth: userRecord.dateOfBirth,
      firebaseID: userRecord.firebaseID,
    );

    // Update the data in the database, if applicable.
    _databaseService.updateData(userID, updatedUserRecord);
  }

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
          "Profile Page",
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
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: Make the PP a clipped picture (e.g., CircleAvatar).
              Image.asset(
                'assets/profile_pic.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 24,
              ),
              ...buildInputBox(_firstNameController, "First Name"),
              ...buildInputBox(_lastNameController, "Last Name"),
              ...buildInputBox(_emailController, "Email Address"),
              ...buildInputBox(_phoneNumberController, "Phone Number"),
              SizedBox(
                width: 380,
                height: 60,
                child: TextButton(
                  onPressed: _updatePatientData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add some space between the icon and text
                      Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Creates the user input box, used acorss many pages.
/// Takes in the controller and hintText.
/// Calls the InputBoxStyle method from form helpers.
List<Widget> buildInputBox(TextEditingController controller, String hintText) {
  return [
    Text(
      hintText,
      style: const TextStyle(color: grayColor, fontSize: 12),
    ),
    const SizedBox(height: 8),
    FormHelpers.inputBoxStyle(controller),
    const SizedBox(height: 16),
  ];
}
