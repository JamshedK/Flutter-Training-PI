import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/form_helpers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(text: "John");
    _lastNameController = TextEditingController(text: "Doe");
    _emailController = TextEditingController(text: "JohnDoe@gmail.com");
    _phoneNumberController = TextEditingController(text: "333-000-9020");
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

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
                  onPressed: () {},
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
                        'Scan Your MRN',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.camera_alt),
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


// TODO: Review this.
// class _ProfileColumn extends StatelessWidget {
//   const _ProfileColumn({
//     required this.labels,
//     required this.controllers,
//   });

//   final List<String> labels;
//   final List<TextEditingController> controllers;

//   @override
//   Widget build(BuildContext context) {
//     assert(labels.length == controllers.length);

//     return Column(
//       children: [
//         for (int i = 0; i < labels.length; ++i) ...[
//           Text(labels[i]),
//           const SizedBox(height: 8),
//           buildInputBox(controllers[i]),
//           const SizedBox(height: 16),
//         ],
//       ],
//     );
//   }
// }