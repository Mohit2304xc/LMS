import 'package:flutter/material.dart';
import 'package:dummy1/Widgets/LOgin/FormDivider.dart';
import 'package:dummy1/Widgets/LOgin/SocialButton.dart';

import '../Widgets/signup/signupform.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's create an account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              const SignUpForm(),
              const SizedBox(
                height: 16,
              ),
              const FormDivider(),
              const SizedBox(height: 16),
              const SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}

