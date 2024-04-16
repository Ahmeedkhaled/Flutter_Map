import 'package:flutter/material.dart';
import 'package:my_profile/core/routes.dart';
import 'package:my_profile/presentation/widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
 final GlobalKey _phoneFormKey=GlobalKey<FormState>();

  LoginScreen({super.key});
  Widget _buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
  Widget _buildNextButton(BuildContext context){
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: (){
          Navigator.of(context).pushNamed(MyRoutes.otpScreen);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text("Next",style: TextStyle(color: Colors.white,fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _phoneFormKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroText(),
              _sizedBox(),
              TextFormWidget(),
                            _sizedBox(),
              _buildNextButton(context)
            ],
          ),
        ),
      ),
    ));
  }
}
