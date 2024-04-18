import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/LoginController.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {
              //controller.googleSignIn();
            },
            icon: const Image(
                width: 14,
                height: 14,
                image: AssetImage("assets/images/loginlogo/download (2).png")),
          ),
        ),
      ],
    );
  }
}
