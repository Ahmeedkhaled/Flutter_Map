import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/buseniess_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:my_profile/core/routes.dart';
import 'package:my_profile/core/theme_app.dart';
import 'package:my_profile/presentation/widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  late String phoneNumber;
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  PhoneAuthCubit viewModel=PhoneAuthCubit();

  LoginScreen({Key? key}) : super(key: key);

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

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MyRoutes.otpScreen);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          "Next",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void _showProgressIndecator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) => alertDialog,
    );
  }

  Widget _buildPhoneNumberSubmittedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      bloc: viewModel,
        listenWhen: (previous, current) {
      return previous != current;
    }, listener: (context, state) {
      if (state is PhoneAuthLoading) {
        _showProgressIndecator(context);
      }
      if (state is PhoneAuthSubmited) {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(MyRoutes.otpScreen,arguments: phoneNumber);
      }
      if(state is PhoneAuthError){
        Navigator.pop(context);
        String errorMsg=state.errorMessage.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg),backgroundColor: Colors.black,duration: Duration(seconds: 3),));
      }
    },
    child: Container(),
    );
  }

  void updatePhoneNumber(String number) {
    phoneNumber = number;
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
                TextFormWidget(
                  onPhoneNumberChanged: updatePhoneNumber,
                ),
                _sizedBox(),
                _buildNextButton(context),
                _buildPhoneNumberSubmittedBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
