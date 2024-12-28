import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../login/login_screen.dart';
import '../DbHelper/database_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  XFile? _profileImage;
  String? userRole; // To hold the selected role

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  // Handle the registration logic
  Future<void> _registerUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        userRole == null) {
      // Show error if fields are empty or role is not selected
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all fields and select a role"),
      ));
      return;
    }

    final user = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'user_type': userRole == "Buy/Sell/Rent" ? 1 : 2,
      'additional_info': '', // You can add additional fields if required
    };

    // Register the user in the database
    final result = await DatabaseHelper.instance.registerUser(user);
    if (result != -1) {
      // If registration is successful, navigate to login screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // If registration fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Registration failed. Please try again."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 238, 231),
                  Color.fromARGB(255, 231, 249, 255)
                ],
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
              ),
            ),
          ),
          // Abstract Circles
          Positioned(
            top: -100,
            left: -50,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -70,
            child: CircleAvatar(
              radius: 180,
              backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
            ),
          ),
          Positioned(
            top: 100,
            right: 50,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
            ),
          ),
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    const Text(
                      "Create Account",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileImagePicker(
                    pickImage: _pickImage, profileImage: _profileImage),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: nameController,
                    label: "Full Name",
                    icon: Icons.person),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: emailController,
                    label: "Email",
                    icon: Icons.email),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    icon: Icons.lock,
                    obscureText: true),
                const SizedBox(height: 30),
                const Text("Choose your main service to offer",
                    style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                // Role selection using radio buttons
                Row(
                  children: [
                    Radio<String>(
                      value: "Buy/Sell/Rent",
                      groupValue: userRole,
                      onChanged: (value) {
                        setState(() {
                          userRole = value;
                        });
                      },
                    ),
                    const Text("Buy/Sell/Rent"),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: "Car Repair Shop",
                      groupValue: userRole,
                      onChanged: (value) {
                        setState(() {
                          userRole = value;
                        });
                      },
                    ),
                    const Text("Car Repair Shop"),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerUser, // Call _registerUser when pressed
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28435A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImagePicker extends StatelessWidget {
  final VoidCallback pickImage;
  final XFile? profileImage;

  const ProfileImagePicker({
    super.key,
    required this.pickImage,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundImage:
            profileImage != null ? FileImage(File(profileImage!.path)) : null,
        child: profileImage == null
            ? const Icon(Icons.camera_alt, size: 40)
            : null,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
