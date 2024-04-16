import 'package:flutter/material.dart';
import 'package:my_profile/presentation/widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  Widget _buildIntroText() {
    return Column(
      children: [
        const Text(
          "What is Your Phone Number?",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            "Please enter Your Phone Number To Verify Your Account",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: UniqueKey(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroText(),
              _sizedBox(),
              TextFormWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}
