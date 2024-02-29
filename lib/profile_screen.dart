import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/form_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/ProfilePic.png'),
              const Text(
                "First Name",
                style: TextStyle(color: grayColor, fontSize: 16),
              ),
              const Text(
                "Last Name",
                style: TextStyle(color: grayColor, fontSize: 16),
              ),
              const Text(
                "Email",
                style: TextStyle(color: grayColor, fontSize: 16),
              ),
              const Text(
                "Phone Number",
                style: TextStyle(color: grayColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
