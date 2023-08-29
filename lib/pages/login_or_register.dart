import 'package:chatlyapp/pages/login_page.dart';
import 'package:chatlyapp/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showBooklistPage = true;

  void togglePages(){
    setState(() {
      showBooklistPage = !showBooklistPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showBooklistPage){
      return LoginPage(onTap: togglePages);
    }
    else{
      return RegisterPage(onTap: togglePages);
    }
  }
}
