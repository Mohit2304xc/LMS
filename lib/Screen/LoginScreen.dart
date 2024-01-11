import 'package:flutter/material.dart';
import '../Widgets/LOgin/FormDivider.dart';
import '../Widgets/LOgin/LOginForm.dart';
import '../Widgets/LOgin/LoginHeader.dart';
import '../Widgets/LOgin/SocialButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 56, right: 24, left: 24, bottom: 24),
          child: Column(
            children: [
              LoginHeader(),
              LoginForm(),
              FormDivider(),
              SizedBox(height: 16,),
              SocialButton()
            ],
          ),
        ),
      ),
    );
  }
}








