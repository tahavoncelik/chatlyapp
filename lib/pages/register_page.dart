import 'package:chatlyapp/bloc/auth_bloc.dart';
import 'package:chatlyapp/bloc/auth_event.dart';
import 'package:chatlyapp/components/my_button.dart';
import 'package:chatlyapp/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // TextControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign Up Users
  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password do not match!')));
      return;
    }
    try {
      context.read<AuthBloc>().add(SignUpRequested(emailController.text, passwordController.text));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff091228),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'lib/assets/mmlogo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Email
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obsecureText: false),
                const SizedBox(
                  height: 10,
                ),
                // Password
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password ',
                    obsecureText: true),
                // Confirm Password
                const SizedBox(
                  height: 10,
                ),
                // Password
                MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password ',
                    obsecureText: true),
                const SizedBox(
                  height: 25,
                ),
                // Sign In Button
                MyButton(onTap: signUp, text: "Sign Up"),
                const SizedBox(
                  height: 20,
                ),
                // Register Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
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
