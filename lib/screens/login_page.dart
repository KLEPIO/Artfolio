import 'package:artfolio/components/buttons.dart';
import 'package:artfolio/components/textfield.dart';
import 'package:artfolio/helper/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // show loading circle
      if (context.mounted) Navigator.pop(context);
    }
    // display any errors
    on FirebaseAuthException catch (e) {
      // show loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
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

          const SizedBox(height: 25),

          // sign in button
          Buttons(
            text: "Login",
            onTap: login,
          ),

          const SizedBox(height: 25),

          // register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.grey.shade400),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  " Register Here",
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
