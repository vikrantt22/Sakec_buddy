import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_services.dart';

class LogInPage extends StatefulWidget {
  final void Function()? onTap;
  const LogInPage({super.key, required this.onTap});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //sign in
  void SignIn() async {
    //get the auth services
    final authService = Provider.of<AuthServices>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.message,
                  size: 160,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 10),
                //welcome back message
                const Text(
                  "Welcome back! you've been missed :)",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                //email textfield
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 15),
                //password textfield
                MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),
                //forgot password

                //Login button
                const SizedBox(
                  height: 25,
                ),
                MyButton(onTap: SignIn, text: "SignIN"),
                SizedBox(
                  height: 20,
                ),
                //Not a memeber signUp
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
