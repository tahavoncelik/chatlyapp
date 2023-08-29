import 'package:chatlyapp/bloc/auth_event.dart';
import 'package:chatlyapp/components/my_button.dart';
import 'package:chatlyapp/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // SignIn Users
  Future<void> signIn() async {
    try{
      context.read<AuthBloc>().add(SignInRequested(emailController.text, passwordController.text));
    }
        catch (e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
                  height: 30,
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
                const SizedBox(
                  height: 25,
                ),
                // Sign In Button
                MyButton(onTap: signIn, text: "Sign In"),
                const SizedBox(
                  height: 30,
                ),
                // Register Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
