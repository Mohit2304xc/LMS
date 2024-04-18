import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Image(
            height: 150,
            image: AssetImage("assets/images/prabishalogo.png"),
          ),
        ),
        Text(
          "Please Provide your email and password",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}