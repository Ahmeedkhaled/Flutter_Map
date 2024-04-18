import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/buseniess_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:my_profile/core/routes.dart';
import 'package:my_profile/core/theme_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget{
  late String otpCode;
   OtpScreen({super.key});
late String phoneNumber;
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
Widget _buildPhoneVerificationBloc(){
   return BlocListener<PhoneAuthCubit, PhoneAuthState>(
        listenWhen: (previous, current) {
      return previous != current;
    }, listener: (context, state) {
      if (state is PhoneAuthLoading) {
        _showProgressIndecator(context);
      }
      if (state is PhoneOtpVerified) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed(MyRoutes.homePage);
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
  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)!.settings.arguments as String;
     phoneNumber=args;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32,vertical: 88),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroText(),
              const SizedBox(height: 88),
              _buildPinCodeField(context),
              const SizedBox(height: 60),
              _buildVerifyButton(context),
              _buildPhoneVerificationBloc(),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Verify Your Phone Number",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(text: TextSpan(
            text: "Enter your 6 digit code Number sent to ",style: const TextStyle(color:Colors.black,fontSize: 18,height: 1.4),
            children: <TextSpan>[
              TextSpan(
                text: phoneNumber,
                style: const TextStyle(color: ThemeApp.mainColor)
              )
                        ]
          ))
        ),
      ],
    );
  }
  Widget _buildPinCodeField(BuildContext context){
    return PinCodeTextField(
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.phone,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        borderWidth: 1,
        activeColor: ThemeApp.mainColor,
        inactiveColor:ThemeApp.mainColor ,
        inactiveFillColor: Colors.white,
        selectedColor:ThemeApp.mainColor ,
        selectedFillColor:Colors.white ,
        activeFillColor: ThemeApp.lightBlue,
        fieldHeight: 50,
        fieldWidth: 40,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
     
      onCompleted: (code) {
        otpCode=code;
        print("Completed");
      },
      onChanged: (value) {
        print(value);
       
      },
      appContext: context,
    );
  }
  void _login(BuildContext context){
    BlocProvider.of<PhoneAuthCubit>(context).submitOtp(otpCode);
  }
  Widget _buildVerifyButton(BuildContext context){
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: (){
          _showProgressIndecator(context);
          _login(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text("Verify",style: TextStyle(color: Colors.white,fontSize: 16),
        ),
      ),
    );
  }
}