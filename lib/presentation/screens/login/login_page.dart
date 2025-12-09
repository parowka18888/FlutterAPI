import 'package:firebase_auth_platform_interface/src/providers/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key, required List<EmailAuthProvider> providers});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
  

}