import 'package:artfolio/components/buttons.dart';
import 'package:artfolio/components/textfield.dart';
import 'package:artfolio/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  // register method
  void registerUser() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // check if passwords match
    if (passwordController.text != confirmPassController.text) {
      // show loading circle
      Navigator.pop(context);

      // show user error message
      displayMessageToUser("Passwords do not match.", context);
    }

    // if passwords do match, create user
    else {
      try {
        // create new user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // create user document and add to firestore
        createUserDocument(userCredential);

        // show loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // show loading circle
        Navigator.pop(context);

        //display error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create user document and colllect in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 80,
            color: Colors.grey.shade700,
          ),

          const SizedBox(height: 25),

          Text(
            "ARTFOLIO",
            style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
          ),

          const SizedBox(height: 50),

          // username textfield
          Textfield(
            hintText: "Username",
            obscureText: false,
            controller: usernameController,
          ),

          const SizedBox(height: 10),

          // email textfield
          Textfield(
            hintText: "Email",
            obscureText: false,
            controller: emailController,
          ),

          const SizedBox(height: 10),

          // password textfield
          Textfield(
            hintText: "Password",
            obscureText: true,
            controller: passwordController,
          ),

          const SizedBox(height: 10),

          // confirm password
          Textfield(
            hintText: "Confirm Password",
            obscureText: true,
            controller: confirmPassController,
          ),

          const SizedBox(height: 25),

          // register in button
          Buttons(
            text: "Register",
            onTap: registerUser,
          ),

          const SizedBox(height: 25),

          // register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.grey.shade400),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  " Login Here",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )));
  }
}
