import 'package:flutter/material.dart';
import 'package:my_profile/core/theme_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget{
   OtpScreen({super.key});
late String phoneNumber;
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
              _buildVerifyButton(),
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
    return Container(
      child: PinCodeTextField(
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
  animationDuration: Duration(milliseconds: 300),
  backgroundColor: Colors.white,
  enableActiveFill: true,
 
  onCompleted: (code) {

    print("Completed");
  },
  onChanged: (value) {
    print(value);
   
  },
  appContext: context,
),
    );
  }
  
  Widget _buildVerifyButton(){
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: (){},
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